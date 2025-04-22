{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.programs.zed-editor;
in
{
  options = {
    programs.zed-editor = {
      extraThemes = lib.mkOption {
        type = with types; listOf (either str path);
        default = [ ];
      };
    };
  };

  config = mkIf cfg.enable {
    home.file = mkIf (cfg.extraThemes != [ ]) (
      listToAttrs (
        forEach cfg.extraThemes (
          theme:
          let
            baseName = builtins.baseNameOf theme;
            cleanName = match ".*/[a-z0-9]+-(.*)" baseName;
            fileName = if (cleanName != null) then (elemAt cleanName 0) else baseName;
          in
          {
            name = ".config/zed/themes/${fileName}";
            value = {
              source = theme;
            };
          }
        )
      )
    );

    xdg.configFile = {
      "zed/keymap.json".enable = mkForce false;
      "zed/settings.json".enable = mkForce false;
    };
  };
}
