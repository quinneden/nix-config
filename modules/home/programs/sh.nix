{
  config,
  lib,
  user,
  ...
}:

with lib;

let
  shellAliases = {
    cddf = "cd ~/.dotfiles";
    cddl = "cd ~/Downloads";
    ga = "git add";
    gbl = "git branch --list";
    gst = "git status";
    gsur = "git submodule update --init --recursive";
    l = "eza -la --group-directories-first";
    ll = "eza -glAh --octal-permissions --group-directories-first";
    ls = "eza";
    nhs = "nh search";
    push = "git push";
    darwin-man = "man configuration.nix";
    lc = "limactl";
    reboot = "sudo reboot";
    sed = "gsed";
    shutdown = "sudo shutdown -h now";
  };

  sessionVariables = {
    EDITOR = "micro";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    MICRO_TRUECOLOR = "1";
    LESS = "-RF";
    PAGER = "less";
    TMPDIR = "/tmp";
  };
in
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
    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.path = "${config.xdg.configHome}/zsh/.zsh_history";

    oh-my-zsh = {
      enable = true;
      plugins = [
        "colored-man-pages"
        "iterm2"
      ];
    };

    completionInit = ''
      autoload -U compinit && compinit
      autoload -U bashcompinit && bashcompinit
    '';

    # Common order values:
    #   - 500 (mkBefore): Early initialization (replaces initExtraFirst)
    #   - 550: Before completion initialization (replaces initExtraBeforeCompInit)
    #   - 1000 (default): General configuration (replaces initExtra)
    #   - 1500 (mkAfter): Last to run configuration
    initContent = mkMerge [
      (mkOrder 500 ''
        export HOMEBREW_PREFIX="/opt/homebrew";
        export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX";
        export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
        export INFOPATH="/opt/homebrew/share/info:''${INFOPATH:-}";
        [[ -z ''${MANPATH-} ]] || export MANPATH=":''${MANPATH#:}";
        fpath[1,0]="/opt/homebrew/share/zsh/site-functions";

        typeset -U path

        if [[ -n $IN_NIX_SHELL || -n $name ]]; then
          for ((i=''${#path[@]}; i>=1; i--)); do
            if [[ ''${path[$i]} =~ '/nix/store' ]]; then
              idx=$((i + 1))
              break
            fi
          done
          idx=''${idx:-1}
          path[$idx,$((idx + 1))]=("/opt/homebrew/bin" "/opt/homebrew/sbin")
        else
          path+=("/opt/homebrew/bin" "/opt/homebrew/sbin")
        fi
      '')
      (mkOrder 550 ''
        typeset -U path fpath

        path+=($HOME/.local/bin)

        fpath+=(
          ${optionalString config.nix.enable config.nix.package + "/share/zsh/site-functions"}
          /etc/profiles/per-user/${user}/share/zsh/site-functions
          ${config.xdg.configHome}/zsh/completions
        )
      '')

      (mkOrder 1000 ''
        for f (${config.xdg.configHome}/zsh/{functions,drop-ins}/*(N.)); do
          source "$f"
        done

        [[ -f $HOME/.cargo/env ]] && source "$HOME/.cargo/env"
      '')
    ];
  };
}
