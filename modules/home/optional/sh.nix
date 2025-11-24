{
  config,
  inputs,
  lib,
  user,
  ...
}:

with lib;

let
  homeDirectory = "/Users/${user}";

  shellAliases = {
    cddf = "z ~/.dotfiles";
    cddl = "z ~/Downloads";
    darwin-man = "man configuration.nix";
    ga = "git add";
    gbl = "git branch --list";
    gcap = "git commit --amend --no-edit && git push --force";
    gpl = "git pull";
    gps = "git push";
    gst = "git status";
    gsur = "git submodule update --init --recursive";
    l = "eza -la --group-directories-first";
    lc = "limactl";
    ll = "eza -glAh --octal-permissions --group-directories-first";
    ls = "eza";
    nhs = "nh search";
    reboot = "sudo reboot";
    sed = "gsed";
    shutdown = "sudo shutdown -h now";
  };

  sessionVariables = {
    EDITOR = "micro";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    MICRO_TRUECOLOR = "1";
    NH_DARWIN_FLAKE = "${homeDirectory}/.dotfiles";
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
    history.path = "${config.programs.zsh.dotDir}/.zsh_history";

    oh-my-zsh = {
      enable = true;
      plugins = [
        "colored-man-pages"
        "iterm2"
      ];
    };

    completionInit = ''
      autoload -Uz compinit; compinit
      autoload -U +X bashcompinit; bashcompinit
      complete -o nospace -C ${config.xdg.configHome}/go/bin/gocomplete go
    '';

    # Common order values:
    #   - 500 (mkBefore): Early initialization (replaces initExtraFirst)
    #   - 550: Before completion initialization (replaces initExtraBeforeCompInit)
    #   - 1000 (default): General configuration (replaces initExtra)
    #   - 1500 (mkAfter): Last to run configuration
    initContent = mkMerge [
      (mkOrder 500 ''
        export HOMEBREW_PREFIX="/opt/homebrew"
        export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
        export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
        export INFOPATH="/opt/homebrew/share/info:''${INFOPATH:-}"
        [[ -z ''${MANPATH-} ]] || export MANPATH=":''${MANPATH#:}"
        fpath[1,0]="/opt/homebrew/share/zsh/site-functions"

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
          eval "$(PATH_HELPER_ROOT=/opt/homebrew /usr/libexec/path_helper -s)"
        fi
      '')
      (mkOrder 550 ''
        typeset -U path fpath

        path+=(
          "$HOME"/.local/bin
          "$HOME"/.local/go/bin(N/)
          /opt/podman/bin(N/)
        )

        fpath+=(
          ${config.xdg.configHome}/zsh/completions
          ${config.xdg.configHome}/zsh/drop-ins
          ${config.xdg.configHome}/zsh/functions
          ${optionalString config.nix.enable config.nix.package + "/share/zsh/site-functions"}
          /etc/profiles/per-user/${user}/share/zsh/site-functions
        )

        ZFUNCTION_DIGEST=$ZDOTDIR/functions/zfunctions.zwc

        if [[ ! -f $ZFUNCTION_DIGEST ]] \
        || [[ $ZFUNCTION_DIGEST -ot $ZDOTDIR/functions(#qN.om[1]) ]]; then
          zcompile $ZFUNCTION_DIGEST $ZDOTDIR/functions/*(N.)
        fi

        autoload -Uz $ZDOTDIR/functions/*(N.:t)
      '')

      (mkOrder 1000 ''
        [[ -f $HOME/.cargo/env ]] && source "$HOME/.cargo/env"
      '')

      (mkOrder 1500 ''
        (
          zcompare() {
            if [[ -s $1 && ( ! -s $1.zwc || $1 -nt $1.zwc) ]]; then
              zcompile $1
            fi
          }

          setopt EXTENDED_GLOB

          zcompare $ZDOTDIR/.zshrc

          for file in $ZDOTDIR/.zcomp^(*.zwc)(.); do
            zcompare $file
          done

          if [[ $ZDOTDIR/zfunctions.zwc -ot $ZDOTDIR/functions(#qN.om[1]) ]]; then
            zcompile $ZDOTDIR/functions/zfunctions.zwc $ZDOTDIR/functions/*(N.)
          fi

          for file in $ZDOTDIR/drop-ins/^(*.zwc)(.); do
            zcompare $file
          done
        ) &!
      '')
    ];
  };

  home.activation."zcompile-rcfiles" =
    inputs.home-manager.lib.hm.dag.entryAfter [ "writeBoundary" ]
      ''
        find ${homeDirectory}/.config/zsh -iname "*.zwc" -delete
      '';
}
