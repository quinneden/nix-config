{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.micro;
  hmLib = inputs.home-manager.lib;
  jsonFormat = pkgs.formats.json { };
in
{
  options = {
    programs.micro = {
      extraSyntax = mkOption {
        type = types.attrs;
        default = { };
      };

      keybindings = mkOption {
        type = jsonFormat.type;
        default = { };
        example = literalExpression ''
          {
            "Ctrl-y" = "Undo";
            "Ctrl-z" = "Redo";
          }
        '';
        description = ''
          Keybindings configuration written to
          {file}`$XDG_CONFIG_HOME/micro/bindings.json`. See
          <https://github.com/zyedidia/micro/blob/master/runtime/help/keybindings.md>
          for more information.
        '';
      };

      plugins = mkOption {
        type =
          with types;
          listOf (oneOf [
            (strMatching "aspell")
            (strMatching "autofmt")
            (strMatching "bookmark")
            (strMatching "bounce")
            (strMatching "cheat")
            (strMatching "detectindent")
            (strMatching "editorconfig")
            (strMatching "go")
            (strMatching "gotham-colors")
            (strMatching "jlabbrev")
            (strMatching "joinLines")
            (strMatching "jump")
            (strMatching "monokai-dark")
            (strMatching "nord-tc-colors")
            (strMatching "palettero")
            (strMatching "lsp")
            (strMatching "quickfix")
            (strMatching "quoter")
            (strMatching "run")
            (strMatching "scratch")
            (strMatching "wakatime")
            (strMatching "zigfmt")
          ]);
      };
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile = mkIf (cfg.keybindings != null) {
      "micro/bindings.json".source = jsonFormat.generate "micro-keybindings" cfg.keybindings;
    };

    home.file = (
      mkIf (cfg.plugins != null) (
        mapAttrs (name: plug: {
          recursive = true;
          target = ".config/micro/plug/" + name;
          source = pkgs.fetchzip {
            url = plug.url;
            hash = plug.hash;
          };
        }) cfg.plugins
      )
      // (mkIf (cfg.extraSyntax != null) (
        lib.mapAttrs (name: path: {
          target = ".config/micro/syntax/" + baseNameOf path;
          source = path;
        }) cfg.extraSyntax
      ))
    );

    home.activation."micro-install-plugins" = mkIf (cfg.plugins != [ ]) (
      hmLib.hm.dag.entryAfter [ "writeBoundary" ] ''
        PATH=${pkgs.micro}/bin:$PATH
        pluginsList=(${builtins.concatStringsSep " " cfg.plugins})
        pluginsInstalled=($(micro -plugin list | tail -n +2 | cut -f1 -d' ' | sort -u))
        pluginsToInstall=()
        # pluginsToRemove=()
        for plugin in "''${pluginsList[@]}"; do
            if [[ ! " ''${pluginsInstalled[@]} " =~ " $plugin " ]]; then
                pluginsToInstall+=("$plugin")
            fi
        done
        # for plugin in "''${pluginsInstalled[@]}"; do
        #     if [[ ! " ''${pluginsList[@]} " =~ " $plugin " ]]; then
        #         pluginsToRemove+=("$plugin")
        #     fi
        # done
        # for plugin in "''${pluginsToRemove[@]}"; do
        #     micro -plugin remove "$plugin"
        # done
        for plugin in "''${pluginsToInstall[@]}"; do
            micro -plugin install "$plugin"
        done
      ''
    );
  };
}
