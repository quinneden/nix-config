{ inputs, ... }:

{
  imports = [ inputs.rift.homeModules.default ];

  programs.rift = {
    enable = true;

    settings = {
      # Animations
      animate = true;
      animationDuration = 0.3;
      animationFps = 100.0;
      animationEasing = "ease_in_out";

      # Space activation behavior
      defaultDisable = false;

      # Mouse/Focus behavior
      focusFollowsMouse = true;
      mouseFollowsFocus = true;
      mouseHidesOnFocus = true;
      focusFollowsMouseDisableHotkey = "Fn";

      # Auto focus blacklist
      autoFocusBlacklist = [ ];

      # Run commands on start
      runOnStart = [ ];

      # Hot reloading
      hotReload = true;

      # Layout configuration
      layout = {
        mode = "traditional";

        stack = {
          stackOffset = 40.0;
          defaultOrientation = "perpendicular";
        };

        gaps = {
          outer = {
            top = 0;
            left = 0;
            bottom = 0;
            right = 0;
          };

          inner = {
            horizontal = 0;
            vertical = 0;
          };

          # Per-display overrides
          perDisplay = {
            "11111111-2222-3333-4444-555555555555" = {
              outer = {
                top = 20;
                left = 20;
                bottom = 20;
                right = 20;
              };
              inner = {
                horizontal = 8;
                vertical = 8;
              };
            };
          };
        };
      };

      # UI configuration
      ui = {
        menuBar = {
          enabled = false;
          showEmpty = false;
          mode = "all";
          activeLabel = "index";
          displayStyle = "layout";
        };

        stackLine = {
          enabled = false;
          horizPlacement = "top";
          vertPlacement = "left";
          thickness = 0.0;
          spacing = 0.0;
        };

        missionControl = {
          enabled = false;
          fadeEnabled = false;
          fadeDurationMs = 180.0;
        };
      };

      # Trackpad gestures
      gestures = {
        enabled = false;
        invertHorizontalSwipe = false;
        swipeVerticalTolerance = 0.4;
        skipEmpty = true;
        fingers = 3;
        distancePct = 0.08;
        hapticsEnabled = true;
        hapticPattern = "level_change";
      };

      # Window snapping
      windowSnapping = {
        dragSwapFraction = 0.3;
      };
    };

    # Virtual workspaces
    virtualWorkspaces = {
      enabled = true;
      defaultWorkspaceCount = 4;
      autoAssignWindows = true;
      preserveFocusPerWorkspace = true;
      workspaceAutoBackAndForth = false;
      reapplyAppRulesOnTitleChange = false;
      defaultWorkspace = 0;
      workspaceNames = [
        "first"
        "second"
      ];
      appRules = [ ];
    };

    # Modifier combinations
    modifierCombinations = {
      comb1 = "Alt + Shift";
    };

    # Key bindings
    keys = {
      "Alt + Z" = "toggle_space_activated";
      "Alt + H" = {
        move_focus = "left";
      };
      "Alt + J" = {
        move_focus = "down";
      };
      "Alt + K" = {
        move_focus = "up";
      };
      "Alt + L" = {
        move_focus = "right";
      };
      "comb1 + H" = {
        move_node = "left";
      };
      "comb1 + J" = {
        move_node = "down";
      };
      "comb1 + K" = {
        move_node = "up";
      };
      "comb1 + L" = {
        move_node = "right";
      };
    };
  };
  # programs.rift = {
  #   enable = true;
  #   startAtLogin = true;

  #   settings = {
  #     animate = true;
  #     animationDuration = 0.3;
  #     animationEasing = "ease_in_out";
  #     animationFps = 100;
  #     autoFocusBlacklist = [ ];
  #     focusFollowsMouse = true;
  #     gestures = {
  #       distancePct = 0.08;
  #       enabled = false;
  #       fingers = 3;
  #       hapticPattern = "level_change";
  #       hapticsEnabled = true;
  #       invertHorizontalSwipe = false;
  #       skipEmpty = true;
  #       swipeVerticalTolerance = 0.4;
  #     };
  #     layout = {
  #       gaps = {
  #         inner = {
  #           horizontal = 0;
  #           vertical = 0;
  #         };
  #         outer = {
  #           bottom = 0;
  #           left = 0;
  #           right = 0;
  #           top = 0;
  #         };
  #       };
  #       mode = "traditional";
  #       stack = {
  #         defaultOrientation = "perpendicular";
  #         stackOffset = 40;
  #       };
  #     };
  #     mouseFollowsFocus = true;
  #     mouseHidesOnFocus = true;
  #     runOnStart = [ ];
  #     ui = {
  #       menuBar = {
  #         enabled = false;
  #         showEmpty = false;
  #       };
  #       missionControl = {
  #         enabled = false;
  #         fadeDurationMs = 180;
  #         fadeEnabled = false;
  #       };
  #       stackLine = {
  #         enabled = false;
  #         horizPlacement = "top";
  #         spacing = 0;
  #         thickness = 0;
  #         vertPlacement = "left";
  #       };
  #     };
  #     windowSnapping = {
  #       dragSwapFraction = 0.3;
  #     };
  #   };

  #   virtualWorkspaces = {
  #     appRules = [ ];
  #     autoAssignWindows = true;
  #     defaultWorkspace = 0;
  #     defaultWorkspaceCount = 4;
  #     enabled = true;
  #     preserveFocusPerWorkspace = true;
  #     workspaceAutoBackAndForth = false;
  #     workspaceNames = [ ];
  #   };
  # };
}
