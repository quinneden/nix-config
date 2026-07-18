{ den, ... }:

{
  den.aspects.blanche = {
    includes = [ den.aspects.virby ];

    darwin = {
      system = {
        defaults = {
          CustomUserPreferences = {
            ".GlobalPreferences".AppleSpacesSwitchOnActivate = true;
            "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
            "com.apple.finder"._FXSortFoldersFirst = true;
            "com.apple.finder".FXDefaultSearchScope = "SCcf";
            "com.apple.finder".ShowExternalHardDrivesOnDesktop = true;
            "com.apple.finder".ShowHardDrivesOnDesktop = false;
            "com.apple.finder".ShowMountedServersOnDesktop = true;
            "com.apple.finder".ShowRemovableMediaOnDesktop = true;
            "com.apple.ImageCapture".disableHotPlug = true;
            "com.apple.screencapture".location = "~/Desktop";
            "com.apple.screencapture".type = "png";
            "com.apple.screensaver".askForPassword = 1;
            "com.apple.screensaver".askForPasswordDelay = 15;
            "com.apple.spaces".spans-displays = 0;
            "com.apple.WindowManager".EnableStandardClickToShowDesktop = 0;
            "com.apple.WindowManager".HideDesktop = 0;
            "com.apple.WindowManager".StageManagerHideWidgets = 1;
            "com.apple.WindowManager".StandardHideDesktopIcons = 0;
            "com.apple.WindowManager".StandardHideWidgets = 0;
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

          trackpad.ActuationStrength = 0;
        };

        keyboard = {
          enableKeyMapping = true;
          remapCapsLockToEscape = true;
        };
      };
    };
  };
}
