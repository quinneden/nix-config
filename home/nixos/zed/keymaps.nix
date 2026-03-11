[
  {
    bindings = {
      cmd-shift-c = null;
      cmd-shift-e = "project_panel::ToggleFocus";
      cmd-shift-g = "git_panel::ToggleFocus";
      cmd-shift-p = "command_palette::Toggle";
      cmd-shift-w = "terminal_panel::ToggleFocus";
    };
  }
  {
    bindings = {
      cmd-r = "workspace::ToggleRightDock";
      cmd-w = "pane::CloseActiveItem";
    };
    context = "MessageEditor > Editor";
  }
  {
    bindings = {
      cmd-enter = "assistant::Assist";
      cmd-r = "workspace::ToggleRightDock";
      cmd-shift-c = "assistant::CycleMessageRole";
      cmd-w = "pane::CloseActiveItem";
    };
    context = "ContextEditor > Editor";
  }
  {
    bindings = {
      alt-backspace = "editor::DeleteToPreviousWordStart";
      cmd-d = "editor::DuplicateLineDown";
      cmd-enter = "assistant::InlineAssist";
      cmd-j = "editor::JoinLines";
      "cmd-k cmd-shift-v" = "markdown::OpenPreview";
      "cmd-k i" = "editor::SortLinesCaseInsensitive";
      cmd-r = "agent::ToggleFocus";
      cmd-shift-f = "pane::DeploySearch";
      cmd-shift-right = [
        "editor::SelectToEndOfLine"
        { stop_at_soft_wraps = true; }
      ];
      cmd-shift-v = "markdown::OpenPreviewToTheSide";
      ctrl-d = "editor::DuplicateLineDown";
    };
    context = "Editor && mode == full && !(ContextEditor > Editor)";
  }
  {
    bindings = {
      cmd-w = "pane::CloseActiveItem";
      pagedown = [
        "editor::MoveDownByLines"
        { lines = 35; }
      ];
      pageup = [
        "editor::MoveUpByLines"
        { lines = 35; }
      ];
    };
    context = "Editor";
  }
  {
    bindings = {
      cmd-0 = "pane::ActivateLastItem";
      cmd-1 = [
        "pane::ActivateItem"
        0
      ];
      cmd-2 = [
        "pane::ActivateItem"
        1
      ];
      cmd-3 = [
        "pane::ActivateItem"
        2
      ];
      cmd-4 = [
        "pane::ActivateItem"
        3
      ];
      cmd-5 = [
        "pane::ActivateItem"
        4
      ];
      cmd-6 = [
        "pane::ActivateItem"
        5
      ];
      cmd-7 = [
        "pane::ActivateItem"
        6
      ];
      cmd-8 = [
        "pane::ActivateItem"
        7
      ];
      cmd-9 = [
        "pane::ActivateItem"
        8
      ];
      cmd-alt-left = "pane::ActivatePreviousItem";
      cmd-alt-right = "pane::ActivateNextItem";
      cmd-ctrl-down = "workspace::ActivatePaneDown";
      cmd-ctrl-left = "workspace::ActivatePaneLeft";
      cmd-ctrl-right = "workspace::ActivatePaneRight";
      cmd-ctrl-up = "workspace::ActivatePaneUp";
      "cmd-k c" = "workspace::ToggleCenteredLayout";
      cmd-s = "workspace::Save";
      ctrl-s = "workspace::Save";
    };
    context = "Workspace";
  }
  {
    bindings = {
      cmd-c = "terminal::Copy";
      cmd-shift-w = "workspace::ToggleBottomDock";
      cmd-t = "workspace::NewTerminal";
      cmd-v = "terminal::Paste";
    };
    context = "Terminal";
  }
  {
    bindings = {
      cmd-shift-d = "workspace::ToggleBottomDock";
    };
    context = "DebugPanel";
  }
  {
    bindings = {
      "cmd-k d" = "editor::GoToDefinition";
    };
    context = "Editor";
  }
  {
    bindings = {
      cmd-shift-left = [
        "editor::SelectToBeginningOfLine"
        {
          stop_at_indent = true;
          stop_at_soft_wraps = true;
        }
      ];
    };
    context = "((Editor && mode == full) && !ContextEditor > Editor)";
  }
  {
    bindings = {
      ctrl-shift-a = null;
    };
  }
  {
    bindings = {
      ctrl-shift-a = null;
    };
    context = "Editor";
  }
  {
    bindings = {
      "cmd-k cmd-enter" = "pane::TogglePinTab";
    };
    context = "Pane";
  }
  {
    bindings = {
      ctrl-cmd-right = null;
    };
    context = "(Editor && edit_prediction)";
  }
  {
    bindings = {
      ctrl-cmd-right = null;
    };
    context = "(Editor && edit_prediction_conflict)";
  }
  {
    bindings = {
      "cmd-g cmd-shift-d" = "git::Diff";
    };
    context = "Editor || GitPanel";
  }
  {
    bindings = {
      "ctrl-g d" = null;
    };
    context = "GitPanel";
  }
  {
    bindings = {
      ctrl-cmd-tab = "workspace::ActivatePreviousPane";
    };
  }
  {
    bindings = {
      "cmd-k cmd-shift-r" = "workspace::Reload";
    };
  }
  {
    bindings = {
      "cmd-k cmd-w" = "workspace::CloseWindow";
    };
    context = "PromptLibrary";
  }
  {
    bindings = {
      "cmd-k cmd-shift-w" = "workspace::CloseWindow";
    };
  }
  {
    bindings = {
      cmd-w = null;
    };
    context = "Workspace";
  }
  {
    bindings = {
      "cmd-k right" = "pane::SplitRight";
    };
    context = "Pane";
  }
  {
    bindings = {
      "cmd-k ]" = "pane::SplitAndMoveRight";
    };
  }
  {
    bindings = {
      "cmd-k [" = "pane::SplitAndMoveLeft";
    };
  }
  {
    bindings = {
      "alt-cmd-," = "zed::OpenSettings";
    };
  }
  {
    bindings = {
      "cmd-," = "zed::OpenSettingsFile";
    };
  }
]
