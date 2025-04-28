{ flake, pkgs, ... }: {
  imports = [
    ./nix-index.nix
    ./neovim.nix # Comment this out if you do not want to setup Neovim.
    ./tmux.nix
  ];

  # Recommended Nix settings
  nix = {
    registry.nixpkgs.flake =
      flake.inputs.nixpkgs; # https://yusef.napora.org/blog/pinning-nixpkgs-flake/

    # FIXME: Waiting for this to be merged:
    # https://github.com/nix-community/home-manager/pull/4031
    # nixPath = [ "nixpkgs=${flake.inputs.nixpkgs}" ]; # Enables use of `nix-shell -p ...` etc

    # Garbage collect the Nix store
    gc = {
      automatic = true;
      # Change how often the garbage collector runs (default: weekly)
      # frequency = "monthly";
    };
  };

  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    # Unix tools
    ripgrep # Better `grep`
    fd
    sd
    tree

    # Nix dev
    cachix
    nil # Nix language server
    nix-info
    nixpkgs-fmt
    nixci
    nix-health

    # Dev
    alacritty
    tmate
    silver-searcher
    redis

    # On ubuntu, we need this less for `man home-configuration.nix`'s pager to
    # work.
    less
  ];

  home.shellAliases = {
    git = "git-ai";
    g = "git";
    die = "git stash";
    lg = "lazygit";
    gs = "git status";
    ngs = "nvim -c Neogit";
  };

  # Programs natively supported by home-manager.
  programs = {
    # on macOS, you probably don't need this
    bash = {
      enable = true;
      initExtra = ''
        # Make Nix and home-manager installed things available in PATH.
        export PATH=/run/current-system/sw/bin/:/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
        alias docker=podman
        shopt -s expand_aliases
      '';
    };

    # For macOS's default shell.
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      envExtra = ''
                # Make Nix and home-manager installed things available in PATH.
        export PATH=/run/current-system/sw/bin/:/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
        export LIBCLANG_PATH="/Users/aravind.mallapureddy/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-19.1.2_20250225/esp-clang/lib"
        export PATH="/Users/aravind.mallapureddy/.rustup/toolchains/esp/xtensa-esp-elf/esp-14.2.0_20240906/xtensa-esp-elf/bin:$PATH"
        export PATH="/Users/aravind.mallapureddy/.local/bin:$PATH"


      '';
    };

    # Better `cat`
    bat.enable = true;
    # Type `z <pat>` to cd to some directory
    zoxide.enable = true;
    # Type `<ctrl> + r` to fuzzy search your shell history
    fzf.enable = true;
    jq.enable = true;
    htop.enable = true;

    starship = {
      enable = true;
      settings = {
        username = {
          style_user = "blue bold";
          style_root = "red bold";
          format = "[$user]($style) ";
          disabled = false;
          show_always = true;
        };
        hostname = {
          ssh_only = false;
          ssh_symbol = "🌐 ";
          format = "on [$hostname](bold red) ";
          trim_at = ".local";
          disabled = false;
        };
      };
    };

    # https://nixos.asia/en/direnv
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # https://nixos.asia/en/git
    git = {
      enable = true;
      # userName = "John Doe";
      # userEmail = "johndoe@example.com";
      ignores = [ "*~" "*.swp" ];
      aliases = { ci = "commit"; };
      extraConfig = {
        # init.defaultBranch = "master";
        # pull.rebase = "false";
      };
    };
    lazygit.enable = true;

  };
}
