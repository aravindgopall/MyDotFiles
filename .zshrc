# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/acreed/.oh-my-zsh"

export TERM="xterm-256color"
source "$HOME/.antigen/antigen.zsh"

antigen use oh-my-zsh
antigen bundle arialdomartini/oh-my-git
antigen theme arialdomartini/oh-my-git-themes oppa-lana-style

antigen apply
: ${omg_is_a_git_repo_symbol:='❤'}
: ${omg_has_untracked_files_symbol:='∿'}
: ${omg_has_adds_symbol:='+'}
: ${omg_has_deletions_symbol:='-'}
: ${omg_has_cached_deletions_symbol:='✖'}
: ${omg_has_modifications_symbol:='✎'}
: ${omg_has_cached_modifications_symbol:='☲'}
: ${omg_ready_to_commit_symbol:='→'}
: ${omg_is_on_a_tag_symbol:='⌫'}

#aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias die='git stash'
alias push='git push'
alias gp='git pull'
alias birth='git stash pop'
alias gclone='git clone'
alias c='clear'
alias v='vim .'
alias vrc='vim ~/.vimrc'
alias zrc='vim ~/.zshrc'
alias trc='vim ~/.tmux.config'
alias buw='pulp -w build'
alias bu='pulp build'
alias g='git'
alias start='npm start'
alias gcc='git checkout'
alias jsa='./gradlew createJsaFiles'
alias gd='git diff'
alias vpnsh='sh $HOME/.config/gojek-vpn.sh'
alias cat='bat'

connect-vpn () {
  sh "$HOME/.config/gojek-vpn.sh" "$(oathtool --totp -b $GOJEK_AUTH_TOKEN)"
}
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"
# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

BULLETTRAIN_PROMPT_ORDER=(
  git
  dir
)


#BULLETTRAIN_STATUS_BG = green
#POWERLINE_PATH = "short"
#POWERLINE_GIT_CLEAN="✔"
#POWERLINE_GIT_DIRTY="✘"
#POWERLINE_GIT_ADDED="%F{green}✚%F{black}"
#POWERLINE_GIT_MODIFIED="%F{blue}✹%F{black}"
#POWERLINE_GIT_DELETED="%F{red}✖%F{black}"
#POWERLINE_GIT_UNTRACKED="%F{red}✭%F{black}"
#POWERLINE_GIT_RENAMED="➜"
#POWERLINE_GIT_UNMERGED="═"
#POWERLINE_PATH="short"
#export POWERLINE_HIDE_HOST_NAME="true"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source  ~/.oh-my-zsh/custom/themes/powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_CONTEXT_TEMPLATE="AravindVirat"
POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='black'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='green'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='black'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'
POWERLEVEL9K_VCS_GIT_ICON='\ue60a'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_BATTERY_STAGES="▁▂▃▄▅▆▇█"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND="blue"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_FOREGROUND="red"
zsh_wifi_signal(){
          local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I)
          local airport=$(echo $output | grep 'AirPort' | awk -F': ' '{print $2}')
          if [ "$airport" = "Off" ]; then
              local color='%F{red}'
              echo -n "%{$color%}Wifi Off"
            else
              local ssid=$(echo $output | grep ' SSID' | awk -F': ' '{print $2}')
              local speed=$(echo $output | grep 'lastTxRate' | awk -F': ' '{print $2}')
              local color='%F{red}'
              [[ $speed -gt 100 ]] && color='%F{green}'
              [[ $speed -lt 50 ]] && color='%F{red}'
              echo -n "%{$color%}$ssid $speed Mb/s%{%f%}" # removed char not in my PowerLine font
            fi
   }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/postgresql@10/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/Users/acreed/.config/bin:$PATH"
export LC_ALL=en_US.UTF-8
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export LANG=en_US.UTF-8
export PATH="/Users/acreed/Downloads/apache-maven-3.6.2/bin:$PATH"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home:$JAVA_HOME"
export PATH=$PKG_CONFIG:$PATH
export PATH=$PATH:$HOME/.cargo/bin
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
export PKG_CONFIG="/usr/local/Cellar/librdkafka/HEAD-7aa9b39/lib/pkgconfig"
export PATH="/usr/local/opt/openssl/bin:$PATH"
