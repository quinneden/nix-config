{
  system = {
    activationScripts = {
      postUserActivation.text = ''
        /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      '';
    };

    defaults = {
      CustomUserPreferences = {
        ".GlobalPreferences".AppleSpacesSwitchOnActivate = true;
        "com.apple.AdLib".allowApplePersonalizedAdvertising = false;

        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };

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

        NSGlobalDomain = {
          WebKitDeveloperExtras = true;
          AppleFontSmoothing = 2;
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

      loginwindow = {
        GuestEnabled = false;
        SHOWFULLNAME = false;
        DisableConsoleAccess = false;
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

      trackpad.ActuationStrength = 0;
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    stateVersion = 5;
  };
}
