#!/bin/bash

#current platform
platform = ""

# alias
platform_linux="linux"
platform_macos="macos"

detect_platform(){
    if [[ "${OSTYPE}" == "linux-gnu" ]]; then
        platform=${platform_linux}
    elif [[ "${OSTYPE}" == "linux-musl" ]]; then
        platform=${platform_linux}
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        platform=${platform_macos}
    else
        >&2 echo "Unknown platform";
        return 1;
    fi
}

confirm() {
    local prompt default reply pdefault
    prompt="${1}"

    if [ "${2:-}" = "Y" ]; then
        pdefault="Y/n"
        default=Y
    elif [ "${2:-}" = "N" ]; then
        pdefault="y/N"
        default=N
    else
        pdefault="y/n"
        default=
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "${prompt} [${pdefault}] "

        # Read the answer (use /dev/tty in case stdin is redirected from
        # somewhere else)
        read -r reply </dev/tty

        # Default?
        [ -z "${reply// }" ] && reply=${default}

        # Check if the reply is valid
        case "${reply}" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

install_system_package() {
    [[ -z "${*// }" ]] && return 0

error=<< ERR
"Installing system packages currently not compatible with your package manager.
ERR

    if [[ "${platform}" == "${platform_linux}" ]] ; then
        if [ -n "$(command -v yay)" ]; then
            yay -Syu && yay -S "${@}"
        elif [ -n "$(command -v pacman)" ]; then
            sudo pacman -Syu && sudo pacman -S "${@}"
        elif [ -n "$(command -v apt-get)" ]; then
            sudo apt-get update -qq && sudo apt-get install "${@}" -y
        else
            >&2 echo "$error"
            return 1
        fi

    elif [[ "${platform}" == "${platform_macos}" ]]; then
        if [ -n "$(command -v brew)" ]; then
            brew update && brew install ${@}
        elif [ -n "$(command -v cyg-apt)" ]; then
            cyg-apt update && cyg-apt install ${@}
        elif [ -n "$(command -v cyg-get)" ]; then
            cyg-get ${@}
        else
            >&2 echo ${error}
            return 1
        fi

    else
        >&2 echo "Unknown platform"
        return 1
    fi
}

preinstall () {
cat << STATUS
============================ SETTING UP ENVIRONMENT ===========================
STATUS

    # Cloning Submodules
    echo "${status_prefix} Cloning Submodules"

    cd ${DIR};
    git submodule update --init --recursive;
    cd ${HOME};
}

postinstall () {
    echo "${status_prefix} Rewriting Master URL to Use SSH"

    cd ${DIR} > /dev/null || return;
    git remote set-url origin git@github.com:aravindgopall/MyDotFiles.git;
    cd ${HOME} > /dev/null || return;

cat << EOM

================================= PLEASE READ =================================
If using TMUX, please start it and execute 'C-a' + 'I' to install plugins.
#If using zsh, please source '~/.zshrc' and execute 'zplug install'.
If using nvim or vim, please open the respective editor and run ':PlugInstall'
to install the plugin configuration. This step will likely require system
dependencies for the various plugins. These include:
  - rustc
  - ghc
  - stack
For IDE functionality in neovim, you will likely need to install the various
language servers. These are listed in \`nvim/init.vim\` in the section entitled
'Coc.nvim Configuration'. Nvim will still work without these installed, but none
of the IDE functionality will be available.
EOM
}

link_zsh () {
    echo "${status_prefix} Linking ZSH Configuration"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    ln -sf ${DIR}/.zshrc ${HOME}/.zshrc

    return 0
}

link_tmux () {
    echo "${status_prefix} Linking Tmux configuration"

    ln -sf "${DIR}/.tmux.conf" "${HOME}/.tmux.conf"

    return 0
}

link_alacritty (){
    echo "${status_prefix} Linking Alacritty configuration"
    if [[ ${platform} == "${platform_macos}" ]]; then
      brew Tap homebrew/cask-fonts && brew install --cask font-source-code-pro
    fi

    ln -sf "${DIR}/alacritty.yml" "${HOME}/.alacritty.yml"

    return 0

}

confirm_string() {
    local prompt default reply pdefault
    prompt="${1}"
    default="${2}"

    # Default?
    [[ -n "${default// }" ]] && pdefault=" [${default}]" || pdefault=""

    # Ask the question
    read -r -p "${prompt}${pdefault} " reply

    # Empty reply?
    echo "${reply:-$default}"
}

create_gitconfig () {
    target_file="${HOME}/.gitconfig"

    confirm "Create gitconfig?" || return 0

    echo "${status_prefix} Creating Git Configuration"

    cp "${DIR}/git/gitconfig" "${target_file}"

    if [[ ${platform} == "${platform_macos}" ]]; then
        response=$(confirm_string "Enter git user.name" "$(git config --get user.name)")
        gsed -i "s/##git_name##/${response}/g" ${target_file}

        response=$(confirm_string "Enter git user.email" "$(git config --get user.email)")
        gsed -i "s/##git_email##/${response}/g" ${target_file}

        response=$(confirm_string "Enter git user.signingkey" "$(git config --get user.email)")
        gsed -i "s/##git_signingkey##/${response}/g" ${target_file}
    elif [[ ${platform} == "${platform_linux}" ]]; then
        response=$(confirm_string "Enter git user.name" "$(git config --get user.name)")
        sed -i "s/##git_name##/${response}/g" ${target_file}

        response=$(confirm_string "Enter git user.email" "$(git config --get user.email)")
        sed -i "s/##git_email##/${response}/g" ${target_file}

        response=$(confirm_string "Enter git user.signingkey" "$(git config --get user.email)")
        sed -i "s/##git_signingkey##/${response}/g" ${target_file}
    else
        echo "Unknown platform ${platform}. Cannot execute sed."
    fi

    # Global Gitignore
    ignore_source_file="${DIR}/git/gitignore_global"
    ignore_target_file="${HOME}/.gitignore_global"

    ln -sf ${ignore_source_file} ${ignore_target_file}

    return 0
}

link_karabiner () {
    file_name="karabiner.json"
    karabiner_tgt="${HOME}/.config/karabiner"
    karabiner_src="${DIR}/karabiner/${file_name}"

    if [[ "${platform}" == "${platform_macos}" ]]; then
        echo "${status_prefix} Linking Karabiner Configuration";

        if [[ ! -d ${karabiner_tgt} ]]; then
            mkdir -p ${karabiner_tgt};
        fi

        ln -sf "${karabiner_src}" "${karabiner_tgt}/${file_name}"
    fi
}

link_hammerspoon () {
    hammerspoon_dir="${HOME}/.hammerspoon"
    hammerspoon_src="${DIR}/hammerspoon"

    if [[ ${platform} == "${platform_macos}" ]]; then
        echo "${status_prefix} Linking Hammerspoon Configuration"

        ln -sf ${hammerspoon_src} ${hammerspoon_dir}
    fi
}

link_neovim (){
   echo "${status_prefix} Linking Neovim Configuration"

    nvimrc_dir="${HOME}/.config/nvim"
    nvim_plugs_dir="${HOME}/.local/share/nvim/site"

    if [ ! -d  "${nvimrc_dir}" ]; then
        echo "${status_prefix} Creating "${nvimrc_dir}" for Nvim \
            configuration";
        mkdir -p "${nvimrc_dir}"
    fi

    cp "${DIR}/.vimrc" "${HOME}/.vimrc"
    ln -sf "${DIR}/nvim/init.vim" "${nvimrc_dir}/init.vim"
    #ln -sf "${DIR}/nvim/coc-settings.json" "${nvimrc_dir}/coc-settings.json"

    if [ ! -d "${nvim_plugs_dir}" ]; then
        echo "${status_prefix} Creating "${nvim_plugs_dir}" for plugins";
        mkdir -p "${nvim_plugs_dir}"
    fi

    #if [ ! -e "${nvim_plugs_dir}/autoload" ]; then
        #ln -sf "${DIR}/nvim/autoload" "${nvim_plugs_dir}/autoload"
    #fi

    return 0
}

link_ghci (){
   echo "${status_prefix} Linking GHCI Configuration"
   cp "${DIR}/.ghci" "${HOME}/.ghci"

   return 0

}

install (){
  link_zsh || exit 1
  link_tmux || exit 1
  link_alacritty || exit 1
  link_karabiner || exit 1
  link_hammerspoon || exit 1
  link_neovim || exit 1

  create_gitconfig || exit 1
}

# Main
main (){
  SOURCE="${BASH_SOURCE[0]}"

  while [ -h "${SOURCE}" ]; do # resolve $SOURCE until file no longer a link
    DIR="$( cd -P "$( dirname "${SOURCE}" )" >/dev/null 2>&1 && pwd )"
    SOURCE="$(readlink "${SOURCE}")"
    [[ ${SOURCE} != /* ]] && SOURCE="${DIR}/${SOURCE}" # resolve rel symlinks
  done

  DIR="$( cd -P "$( dirname "${SOURCE}" )" >/dev/null 2>&1 && pwd )"

  #Install
  detect_platform || exit 1
  confirm "Install dotfiles onto ${platform} platform?"|| exit
  install_system_package "${system_deps}" || exit 1
  preinstall || exit 1
  postinstall || exit 1
}

# RUN
main

