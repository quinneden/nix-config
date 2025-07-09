{ inputs }:
{

  imports = [ inputs.matshell.homeManagerModules.default ];

  programs.matshell = {
    # Enable the basic shell
    enable = true;
    # Enable a systemd service for matshell
    autostart = true;
    # Enable matugen theming via custom random wallpaper setter script and rust utility
    # used to base theme and scheme on the HCT properties of the main color.
    # Run this via "wal_set"
    matugenThemeSetter = true;
    # This also sets up the entire matugen config & templates.
    # If you already have matugen set up you may want to omit this.
    # To use the hyprland/hyprlock templates, you would still need to
    # import the generated files and add the color aliases to your config as desired.
    matugenConfig = true;
  };
}
