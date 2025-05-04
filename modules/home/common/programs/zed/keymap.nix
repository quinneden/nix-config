{ lib, pkgs, ... }:
let
  ifLinux = str: lib.optionalString pkgs.stdenv.isLinux str;
in
[
  {
    bindings = {
      cmd-shift-e = "project_panel::ToggleFocus";
      cmd-shift-g = "git_panel::ToggleFocus";
      cmd-shift-p = "command_palette::Toggle";
      cmd-shift-w = "workspace::ToggleBottomDock";
      secondary-shift-c = null;
    };
  }

  {
    bindings = {
      secondary-enter = "assistant::InlineAssist";
    };
    context = "Editor && mode == full && !(ContextEditor > Editor)";
  }

  {
    bindings = {
      secondary-w = "pane::CloseActiveItem";
      secondary-r = "workspace::ToggleRightDock";
    };
    context = "MessageEditor > Editor";
  }

  # Context: ContextEditor > Editor
  {
    bindings = {
      secondary-r = "workspace::ToggleRightDock";
      secondary-shift-c = "assistant::CycleMessageRole";
      secondary-enter = "assistant::Assist";
      secondary-w = "pane::CloseActiveItem";
    };
    context = "ContextEditor > Editor";
  }

  # Context: Editor && mode == full
  {
    bindings = {
      alt-backspace = "editor::DeleteToPreviousWordStart";
      "cmd-k i" = "editor::SortLinesCaseInsensitive";
      ctrl-d = "editor::DuplicateLineDown";
      secondary-d = "editor::DuplicateLineDown";
      secondary-j = "editor::JoinLines";
      secondary-r = "assistant::ToggleFocus";
      secondary-shift-f = "pane::DeploySearch";
      secondary-shift-left = [ "editor::SelectToBeginningOfLine" ] ++ [ { stop_at_soft_wraps = true; } ];
      secondary-shift-right = [ "editor::SelectToEndOfLine" ] ++ [ { stop_at_soft_wraps = true; } ];
    };
    context = "Editor && mode == full && !(ContextEditor > Editor)";
  }

  # Context: Editor && Jupyter
  # {
  #   bindings = {
  #     secondary-escape = "repl::ClearOutputs";
  #   };
  #   context = "Editor && jupyter";
  # }

  # Context: Workspace
  {
    bindings = {
      secondary-0 = "pane::ActivateLastItem";
      secondary-1 = [ "pane::ActivateItem" ] ++ [ 0 ];
      secondary-2 = [ "pane::ActivateItem" ] ++ [ 1 ];
      secondary-3 = [ "pane::ActivateItem" ] ++ [ 2 ];
      secondary-4 = [ "pane::ActivateItem" ] ++ [ 3 ];
      secondary-5 = [ "pane::ActivateItem" ] ++ [ 4 ];
      secondary-6 = [ "pane::ActivateItem" ] ++ [ 5 ];
      secondary-7 = [ "pane::ActivateItem" ] ++ [ 6 ];
      secondary-8 = [ "pane::ActivateItem" ] ++ [ 7 ];
      secondary-9 = [ "pane::ActivateItem" ] ++ [ 8 ];
      secondary-alt-left = "pane::ActivatePreviousItem";
      secondary-alt-right = "pane::ActivateNextItem";
      cmd-ctrl-down = "workspace::ActivatePaneDown";
      cmd-ctrl-left = "workspace::ActivatePaneLeft";
      cmd-ctrl-right = "workspace::ActivatePaneRight";
      cmd-ctrl-up = "workspace::ActivatePaneUp";
      "secondary-k c" = "workspace::ToggleCenteredLayout";
      cmd-w = "pane::CloseActiveItem";
      cmd-s = "workspace::Save";
      ctrl-s = "workspace::Save";
      secondary-return = null;
    };
    context = "Workspace";
  }

  # Context: Terminal
  {
    bindings = {
      "secondary${ifLinux "-shift"}-t" = "workspace::NewTerminal";
      "secondary${ifLinux "-shift"}-c" = "terminal::Copy";
      "secondary${ifLinux "-shift"}-v" = "terminal::Paste";
    };
    context = "Terminal";
  }
]
