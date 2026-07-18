{ lib, inputs, ... }:

{
  den.aspects.shells = {
    homeManager =
      { config, pkgs, ... }:
      let
        inherit (config.home) homeDirectory;
        inherit (pkgs.stdenv) isDarwin;

        shellAliases = {
          cd = "z";
          cddf = "z ~/.dotfiles";
          cddl = "z ~/Downloads";
          gbl = "git branch --list";
          gcap = "git commit --amend --no-edit && git push --force";
          gpl = "git pull";
          gps = "git push";
          gst = "git status";
          gsur = "git submodule update --init --recursive";
          l = "eza -lA --no-permissions --no-user --group-directories-first";
          ll = "eza -glAh --octal-permissions --group-directories-first";
          ls = "eza";
          nhs = "nh search";
          sed = "gsed";
        }
        // lib.optionalAttrs isDarwin {
          lc = "limactl";
          reboot = "sudo reboot";
          shutdown = "sudo shutdown -h now";
        };

        sessionVariables = {
          EDITOR = "micro";
          LANG = "en_US.UTF-8";
          LC_ALL = "en_US.UTF-8";
          LESS = "-RF";
          MICRO_TRUECOLOR = "1";
          ${"NH_" + lib.optionalString isDarwin "DARWIN_" + "FLAKE"} = "${homeDirectory}/.dotfiles";
          PAGER = "less";
          TMPDIR = "/tmp";
        };
      in
      {
        programs.bash = {
          inherit sessionVariables shellAliases;
          enable = true;
          enableCompletion = true;
          historyFileSize = 10000;
        };

        programs.zsh = {
          inherit sessionVariables shellAliases;
          enable = true;
          dotDir = "${config.xdg.configHome}/zsh";
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          history.path = "${config.programs.zsh.dotDir}/.zsh_history";

          oh-my-zsh = {
            enable = true;
            plugins = [ "colored-man-pages" ];
          };

          completionInit = ''
            autoload -Uz compinit; compinit
            autoload -U +X bashcompinit; bashcompinit
          '';

          # Common order values:
          #   - 500 (mkBefore): Early initialization (replaces initExtraFirst)
          #   - 550: Before completion initialization (replaces initExtraBeforeCompInit)
          #   - 1000 (default): General configuration (replaces initExtra)
          #   - 1500 (mkAfter): Last to run configuration
          initContent = lib.mkMerge [
            (lib.mkOrder 500 (
              lib.optionalString isDarwin ''
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
              ''
            ))
            (lib.mkOrder 550 ''
              typeset -U path fpath

              path+=(
                "$HOME"/.local/bin(N/)
                "$HOME"/.local/go/bin(N/)
              )

              fpath+=(
                ${config.xdg.configHome}/zsh/completions
                ${config.xdg.configHome}/zsh/functions
                /nix/var/nix/profiles/default/share/zsh/site-functions(N)
                /etc/profiles/per-user/qeden/share/zsh/site-functions
              )

              ZCOMPLETIONS_DIGEST=$ZDOTDIR/completions/.digest.zwc
              ZFUNCTIONS_DIGEST=$ZDOTDIR/functions/.digest.zwc

              if [[ ! -f $ZCOMPLETIONS_DIGEST || $ZCOMPLETIONS_DIGEST -ot $ZDOTDIR/completions(#qN.om[1]) ]]; then
                zcompile $ZCOMPLETIONS_DIGEST $ZDOTDIR/completions/*(N.)
              fi

              if [[ ! -f $ZFUNCTIONS_DIGEST || $ZFUNCTIONS_DIGEST -ot $ZDOTDIR/functions(#qN.om[1]) ]]; then
                zcompile $ZFUNCTIONS_DIGEST $ZDOTDIR/functions/*(N.)
              fi

              autoload -wUz $ZCOMPLETIONS_DIGEST(N)
              autoload -wUz $ZFUNCTIONS_DIGEST(N)
            '')

            (lib.mkOrder 1000 ''
              [[ -f $HOME/.cargo/env ]] && source "$HOME/.cargo/env"

              bindkey '^U' backward-kill-line
            '')

            (lib.mkOrder 1500 ''
              (
                setopt extendedglob

                zcompare() {
                  if [[ -s $1 && (! -s $1.zwc || $1 -nt $1.zwc) ]]; then
                    zcompile $1
                  fi
                }

                zcompare $ZDOTDIR/.zshrc

                for file in $ZDOTDIR/.zcomp*~*.zwc(.); do
                  zcompare $file
                done

                if [[ $ZFUNCTIONS_DIGEST -ot $ZDOTDIR/functions/*(#qN.om[1]) ]]; then
                  zcompile $ZFUNCTIONS_DIGEST $ZDOTDIR/functions/*(N.)
                fi

                if [[ $ZCOMPLETIONS_DIGEST -ot $ZDOTDIR/completions/*(#qN.om[1]) ]]; then
                  zcompile $ZCOMPLETIONS_DIGEST $ZDOTDIR/completions/*(N.)
                fi
              ) &!

              for file in $ZDOTDIR/drop-ins/*(N.); do
                source $file
              done
            '')
          ];
        };

        home.activation."refreshZwcFiles" = inputs.home-manager.lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          find ${config.xdg.configHome}/zsh "(" -name "*.zwc" -or -name ".zcompdump*" ")" -delete
        '';
      };
  };
}
