{
  den.aspects.ghostty = {
    _.to-users = {
      homeManager = {
        programs.ghostty = {
          enable = true;
          settings = {
            # command = ${pkgs.zsh}/bin/zsh;
            confirm-close-surface = false;
            copy-on-select = true;
            font-family = "VictorMono Nerd Font";
            # gtk-titlebar = false;
            quit-after-last-window-closed = true;
            quit-after-last-window-closed-delay = "5m";
            window-decoration = "auto";
            window-height = 26;
            window-padding-x = 12;
            window-padding-y = 6;
            window-theme = "system";
            window-width = 90;
          };

          systemd.enable = true;
        };
      };
    };
  };
}
