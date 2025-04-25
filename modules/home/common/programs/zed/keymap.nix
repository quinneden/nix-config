[
  {
    bindings = {
      "cmd-," = "zed::OpenSettings";
      "cmd-k cmd-s" = "zed::OpenKeymap";
      cmd-shift-e = "project_panel::ToggleFocus";
      cmd-shift-g = "git_panel::ToggleFocus";
      cmd-shift-p = "command_palette::Toggle";
      cmd-shift-w = "workspace::ToggleBottomDock";
      ctrl-shift-c = null;
    };
  }

  # Context: AssistantPanel
  {
    bindings = {
      ctrl-r = "workspace::ToggleRightDock";
    };
    context = "AssistantPanel";
  }

  # Context: ContextEditor > Editor
  {
    bindings = {
      ctrl-r = "workspace::ToggleRightDock";
      ctrl-shift-c = "assistant::CycleMessageRole";
    };
    context = "ContextEditor > Editor";
  }

  # Context: Editor
  {
    bindings = {
      "cmd-/" = "editor::ToggleComments";
      "cmd-k i" = "editor::SortLinesCaseInsensitive";
      alt-backspace = "editor::DeleteToPreviousWordStart";
      cmd-c = "editor::Copy";
      cmd-d = "editor::DuplicateLineDown";
      cmd-shift-f = [ "workspace::SendKeystrokes" ] ++ [ "ctrl-shift-f" ];
      cmd-shift-left = [ "editor::SelectToBeginningOfLine" ] ++ [ { stop_at_soft_wraps = true; } ];
      cmd-shift-right = [ "editor::SelectToEndOfLine" ] ++ [ { stop_at_soft_wraps = true; } ];
      cmd-shift-z = "editor::Redo";
      cmd-v = "editor::Paste";
      cmd-z = "editor::Undo";
      ctrl-d = "editor::DuplicateLineDown";
      ctrl-j = "editor::JoinLines";
    };
    context = "Editor";
    use_key_equivalents = true;
  }

  # Context: Editor && Jupyter
  {
    bindings = {
      cmd-escape = "repl::ClearOutputs";
    };
    context = "Editor && jupyter";
  }

  # Context: Workspace
  {
    bindings = {
      "cmd-k c" = "workspace::ToggleCenteredLayout";
      cmd-alt-left = "pane::ActivatePreviousItem";
      cmd-alt-right = "pane::ActivateNextItem";
      cmd-ctrl-down = "workspace::ActivatePaneDown";
      cmd-ctrl-left = "workspace::ActivatePaneLeft";
      cmd-ctrl-right = "workspace::ActivatePaneRight";
      cmd-ctrl-up = "workspace::ActivatePaneUp";
      cmd-s = "workspace::Save";
      cmd-w = "pane::CloseActiveItem";
      ctrl-0 = "pane::ActivateLastItem";
      ctrl-1 = [ "pane::ActivateItem" ] ++ [ 0 ];
      ctrl-2 = [ "pane::ActivateItem" ] ++ [ 1 ];
      ctrl-3 = [ "pane::ActivateItem" ] ++ [ 2 ];
      ctrl-4 = [ "pane::ActivateItem" ] ++ [ 3 ];
      ctrl-5 = [ "pane::ActivateItem" ] ++ [ 4 ];
      ctrl-6 = [ "pane::ActivateItem" ] ++ [ 5 ];
      ctrl-7 = [ "pane::ActivateItem" ] ++ [ 6 ];
      ctrl-8 = [ "pane::ActivateItem" ] ++ [ 7 ];
      ctrl-9 = [ "pane::ActivateItem" ] ++ [ 8 ];
      ctrl-r = "assistant::ToggleFocus";
    };
    context = "Workspace";
  }

  # Context: Terminal
  {
    bindings = {
      ctrl-shift-c = "terminal::Copy";
      ctrl-shift-t = "workspace::NewTerminal";
      ctrl-shift-v = "terminal::Paste";
    };
    context = "Terminal";
  }
]
