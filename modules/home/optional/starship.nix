{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableTransience = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "$username"
        "($hostname )"
        "($shell )"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$cmd_duration"
        "$line_break"
        "($nix_shell )"
        "($python )"
        "$character"
      ];

      command_timeout = 1200;

      directory = {
        style = "blue";
      };

      hostname = {
        format = "[@$hostname]($style)";
        style = "bright-black";
      };

      username = {
        style_root = "red";
        style_user = "bright-black";
        format = "[$user]($style)";
      };

      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };

      git_branch = {
        format = "[$branch]($style) ";
        style = "bright-black";
      };

      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted )](218)($ahead_behind$stashed)]($style)";
        style = "cyan";
        ahead = "";
        behind = "";
        diverged = "";
        conflicted = builtins.fromJSON ''"\u200B"'';
        untracked = builtins.fromJSON ''"\u200B"'';
        modified = builtins.fromJSON ''"\u200B"'';
        staged = builtins.fromJSON ''"\u200B"'';
        renamed = builtins.fromJSON ''"\u200B"'';
        deleted = builtins.fromJSON ''"\u200B"'';
        stashed = "";
      };

      git_state = {
        format = "([$state( $progress_current/$progress_total)]($style)) ";
        style = "bright-black";
        rebase = "";
        merge = "";
      };

      cmd_duration = {
        format = " [$duration]($style)";
        style = "yellow";
        min_time = 6000;
      };

      python = {
        format = "[$virtualenv]($style)";
        style = "bright-black";
      };

      nix_shell = {
        format = "[$name]($style)";
        style = "bright-black";
        heuristic = true;
      };

      shell = {
        format = "[$indicator]($style)";
        bash_indicator = "bash:";
        zsh_indicator = "";
        style = "purple";
        disabled = false;
      };
    };
  };
}
