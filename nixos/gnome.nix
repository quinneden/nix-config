{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gnome = {
    enable = lib.mkEnableOption "Gnome";
  };

  config = lib.mkIf config.gnome.enable {
    environment = {
      systemPackages = with pkgs; [
        ghostty
        gnomeExtensions.color-picker
        gnomeExtensions.just-perfection
        gnomeExtensions.user-themes
        morewaita-icon-theme
        phinger-cursors
        qogir-icon-theme
        wl-clipboard
      ];

      gnome.excludePackages = with pkgs; [
        gnome-console
        gnome-photos
        gnome-tour
        gnome-connections
        snapshot
        gedit
        cheese # webcam tool
        epiphany # web browser
        geary # email reader
        evince # document viewer
        totem # video player
        yelp # Help view
        gnome-font-viewer
        gnome-shell-extensions
        gnome-maps
        gnome-music
        gnome-characters
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        gnome-contacts
        gnome-initial-setup
      ];
    };

    services = {
      desktopManager.gnome.enable = false;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      gnome.gcr-ssh-agent.enable = false;
    };

    programs.dconf.profiles.gdm.databases = [
      {
        settings = {
          "org/gnome/desktop/peripherals/touchpad" = {
            tap-to-click = false;
          };
          "org/gnome/desktop/interface" = {
            cursor-theme = "phinger-cursors-dark";
            font-name = "Ubuntu Nerd Font 11";
          };
        };
      }
    ];
  };
}
