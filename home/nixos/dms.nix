{ inputs, ... }:

{
  imports = [ inputs.dms.homeModules.dank-material-shell ];

  programs.dank-material-shell = {
    enable = true;
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
    enableClipboardPaste = true; # Pasting items from the clipboard (wtype)
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = true; # VPN management widget

    clipboardSettings = {
      maxHistory = 25;
      maxEntrySize = 5242880;
      autoClearDays = 1;
      clearAtStartup = true;
      disabled = false;
      disableHistory = false;
      disablePersist = true;
    };

    session = {
      isLightMode = false;
      # Add any other session state settings here
    };

    settings = {
      theme = "dark";
      dynamicTheming = true;
      # Add any other settings here
    };

    systemd = {
      enable = true;
      restartIfChanged = true;
    };
  };
}
