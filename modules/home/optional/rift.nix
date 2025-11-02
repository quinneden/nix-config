{ inputs, ... }:

{
  imports = [ inputs.rift.homeModules.default ];

  programs.rift = {
    enable = true;
    startAtLogin = true;

    settings = {
      animate = true;
      animationDuration = 0.3;
      animationEasing = "ease_in_out";
      animationFps = 100;
      autoFocusBlacklist = [ ];
      focusFollowsMouse = true;
      gestures = {
        distancePct = 0.08;
        enabled = false;
        fingers = 3;
        hapticPattern = "level_change";
        hapticsEnabled = true;
        invertHorizontalSwipe = false;
        skipEmpty = true;
        swipeVerticalTolerance = 0.4;
      };
      layout = {
        gaps = {
          inner = {
            horizontal = 0;
            vertical = 0;
          };
          outer = {
            bottom = 0;
            left = 0;
            right = 0;
            top = 0;
          };
        };
        mode = "traditional";
        stack = {
          defaultOrientation = "perpendicular";
          stackOffset = 40;
        };
      };
      mouseFollowsFocus = true;
      mouseHidesOnFocus = true;
      runOnStart = [ ];
      ui = {
        menuBar = {
          enabled = false;
          showEmpty = false;
        };
        missionControl = {
          enabled = false;
          fadeDurationMs = 180;
          fadeEnabled = false;
        };
        stackLine = {
          enabled = false;
          horizPlacement = "top";
          spacing = 0;
          thickness = 0;
          vertPlacement = "left";
        };
      };
      windowSnapping = {
        dragSwapFraction = 0.3;
      };
    };

    virtualWorkspaces = {
      appRules = [ ];
      autoAssignWindows = true;
      defaultWorkspace = 0;
      defaultWorkspaceCount = 4;
      enabled = true;
      preserveFocusPerWorkspace = true;
      workspaceAutoBackAndForth = false;
      workspaceNames = [ ];
    };
  };
}
