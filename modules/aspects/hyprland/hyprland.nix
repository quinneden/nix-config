{
  den.aspects.hyprland = {
    nixos = {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };
    };

    _.to-users = {
      homeManager = { pkgs, ... }: {
        home.packages = [ pkgs.phinger-cursors-hyprcursor ];

        xdg = {
          configFile."uwsm/env".text = ''
            export XCURSOR_SIZE="24"
          '';

          configFile."uwsm/hyprland-env".text = ''
            export HYPRCURSOR_THEME="phinger-cursors-dark"
            export HYPRCURSOR_SIZE="24"
          '';

          portal.config.common.default = [ "hyprland" ];
        };

        wayland.windowManager.hyprland = {
          enable = true;
          extraConfig = builtins.readFile ./hyprland.lua;
          package = null;
          systemd.enable = false;
        };
      };
    };
  };
}
