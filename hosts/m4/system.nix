{
  system = {
    primaryUser = "quinn";

    defaults = {
      CustomUserPreferences = {
        NSGlobalDomain = {
          WebKitDeveloperExtras = true;
          AppleFontSmoothing = 2;
        };

        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
      };

      loginwindow = {
        GuestEnabled = false;
        SHOWFULLNAME = false;
        DisableConsoleAccess = false;
      };

      trackpad.ActuationStrength = 0;
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    stateVersion = 6;
  };
}
