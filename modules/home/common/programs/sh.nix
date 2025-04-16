{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin isLinux;

  shellAliases =
    {
      cddf = "cd ~/.dotfiles";
      cddl = "cd ~/Downloads";
      gst = "git status";
      gsur = "git submodule update --init --recursive";
      l = "eza -la --group-directories-first";
      ll = "eza -glAh --octal-permissions --group-directories-first";
      ls = "eza";
      push = "git push";
    }
    // lib.optionalAttrs isDarwin {
      lc = "limactl";
      reboot = "sudo reboot";
      sed = "gsed";
      shutdown = "sudo shutdown -h now";
      darwin-man = "man configuration.nix";
      zed = "zed-preview";
    }
    // lib.optionalAttrs isLinux {
      bs = "stat -c%s";
      tree = "eza -ATL3 --git-ignore";
      zed = "zeditor";
    };

  sessionVariables =
    {
      EDITOR = "micro";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      MICRO_TRUECOLOR = "1";
    }
    // lib.optionalAttrs isDarwin {
      PATH = "/run/current-system/sw/bin:/etc/profiles/per-user/quinn/bin:/Users/quinn/.local/bin:\${PATH:+$PATH}";
      TMPDIR = "/tmp";
      PAGER = "less";
      LESS = "-RF";
    }
    // lib.optionalAttrs isLinux {
      NIXOS_CONFIG = "$HOME/.dotfiles";
      NH_FLAKE = "$HOME/.dotfiles";
    };
in
with lib;
{
  programs.bash = {
    inherit shellAliases sessionVariables;
    enable = true;
    enableCompletion = true;
    historyFileSize = 10000;
    bashrcExtra = ''
      git_branch() {
          git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
      }

      RESET="\[\033[0m\]"
      YELLOW="\[\033[0;33m\]"
      BOLD_GREEN="\[\033[1;32m\]"
      BOLD_BLUE="\[\033[1;34m\]"
      PS1="''${BOLD_GREEN}\u@\h''${RESET}:''${BOLD_BLUE}\w''${YELLOW}\$(git_branch)''${RESET}\$ "

      HISTTIMEFORMAT="%F %T "
      HISTCONTROL=ignoredups:erasedups
    '';
  };

  programs.zsh = {
    inherit shellAliases sessionVariables;
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.path = "${config.xdg.configHome}/zsh/.zsh_history";
    oh-my-zsh = {
      enable = true;
      plugins = [
        "colored-man-pages"
        "direnv"
        "eza"
        "fzf"
        "${optionalString isDarwin "iterm2"}"
        "zoxide"
      ];
      custom = "${config.xdg.configHome}/zsh";
    };

    initExtra = ''
      fpath+=(${pkgs.pure-prompt}/share/zsh/site-functions)
      autoload -U promptinit; promptinit
      prompt pure

      for f ($HOME/.config/zsh/functions/*(N.)); do
        source "$f"
      done

      ${optionalString isDarwin "eval $(/opt/homebrew/bin/brew shellenv)"}
    '';

    initExtraBeforeCompInit = ''
      fpath+=(
        ${config.nix.package}/share/zsh/site-functions
        /etc/profiles/per-user/quinn/share/zsh/site-functions
        ${config.xdg.configHome}/zsh/completions
        ${optionalString isDarwin "/opt/homebrew/share/zsh/site-functions"}
      )
    '';

    completionInit = ''
      autoload -U compinit && compinit
      autoload -U bashcompinit && bashcompinit
    '';
  };
}
