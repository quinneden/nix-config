{
  system = {
    defaults = {
      CustomUserPreferences = {
        ".GlobalPreferences".AppleSpacesSwitchOnActivate = true;
        "com.apple.AdLib".allowApplePersonalizedAdvertising = false;

        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          FXDefaultSearchScope = "SCcf";
        };

        "com.apple.ImageCapture".disableHotPlug = true;

        "com.apple.screencapture" = {
          location = "~/Desktop";
          type = "png";
        };

        "com.apple.screensaver" = {
          askForPassword = 1;
          askForPasswordDelay = 15;
        };

        "com.apple.spaces".spans-displays = 0;

        "com.apple.WindowManager" = {
          EnableStandardClickToShowDesktop = 0;
          StandardHideDesktopIcons = 0;
          HideDesktop = 0;
          StageManagerHideWidgets = 1;
          StandardHideWidgets = 0;
        };
      };

      dock = {
        autohide = true;
        autohide-delay = 0.2;
        autohide-time-modifier = 0.7;
        mineffect = "suck";
        show-recents = false;
      };

      finder = {
        _FXShowPosixPathInTitle = true;
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        ShowPathbar = true;
        ShowStatusBar = false;
      };

      NSGlobalDomain = {
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 12;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
      };
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;
}
