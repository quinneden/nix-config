{ pkgs, ... }:

{
  programs.hyprland.withUWSM = true;
  programs.hyprland.enable = true;

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "hyprland";
  };

  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "ignore";
  };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-gtk
  #     xdg-desktop-portal-hyprland
  #     xdg-desktop-portal-wlr
  #     xdg-desktop-portal-gnome
  #   ];
  #   configPackages = with pkgs; [
  #     xdg-desktop-portal-gtk
  #     xdg-desktop-portal-hyprland
  #     xdg-desktop-portal-wlr
  #     xdg-desktop-portal-gnome
  #   ];
  #   config.common = {
  #     default = ["gnome" "hyprland" "gtk"];
  #     "org.freedesktop.impl.portal.Settings" = "gnome";
  #   };
  # };

  # security = {
  #   polkit.enable = true;
  # };

  environment.systemPackages = with pkgs; [
    baobab
    loupe
    nautilus
    wl-clipboard
    wl-gammactl
  ];

  services = {
    gvfs.enable = true;
    devmon.enable = true;
    udisks2.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    accounts-daemon.enable = true;
    gnome = {
      evolution-data-server.enable = true;
      glib-networking.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
      localsearch.enable = true;
      tinysparql.enable = true;
    };
  };
}
