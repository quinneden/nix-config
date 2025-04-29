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
      zed = "zeditor";
      "zed /" = "zeditor .";
    }
    // lib.optionalAttrs isDarwin {
      lc = "limactl";
      reboot = "sudo reboot";
      sed = "gsed";
      shutdown = "sudo shutdown -h now";
      darwin-man = "man configuration.nix";
    }
    // lib.optionalAttrs isLinux {
      tree = "eza -ATL3 --git-ignore";
    };

  sessionVariables =
    {
      EDITOR = "micro";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      MICRO_TRUECOLOR = "1";
    }
    // lib.optionalAttrs isDarwin {
      PATH = "\${PATH:+$PATH}:/Users/quinn/.local/bin";
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
        "${optionalString isDarwin "iterm2"}"
      ];
    };

    completionInit = ''
      autoload -U compinit && compinit
      autoload -U bashcompinit && bashcompinit
    '';

    # Common order values:
    # - 500 (mkBefore): Early initialization (replaces initExtraFirst)
    # - 550: Before completion initialization (replaces initExtraBeforeCompInit)
    # - 1000 (default): General configuration (replaces initExtra)
    # - 1500 (mkAfter): Last to run configuration
    initContent = lib.mkMerge [
      (lib.mkOrder 1000 ''
        for f ($HOME/.config/zsh/functions/*(N.)); do
          source "$f"
        done

        ${optionalString isDarwin "eval $(/opt/homebrew/bin/brew shellenv)"}
      '')
      (lib.mkOrder 550 ''
        fpath+=(
          ${config.nix.package}/share/zsh/site-functions
          /etc/profiles/per-user/quinn/share/zsh/site-functions
          ${config.xdg.configHome}/zsh/completions
          ${optionalString isDarwin "/opt/homebrew/share/zsh/site-functions"}
        )
      '')
    ];
  };
}
