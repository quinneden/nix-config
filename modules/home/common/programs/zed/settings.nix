{ config, pkgs, ... }:
{
  # Font and appearance settings
  agent_font_size = 16.5;
  buffer_font_family = "CaskaydiaCove Nerd Font";
  buffer_font_size = 15.5;
  buffer_line_height = {
    custom = 1.6;
  };
  icon_theme = "Symbols";
  theme = {
    dark = "Aylin";
    light = "Aylin";
    mode = "dark";
  };
  ui_font_family = ".SystemUIFont";
  ui_font_size = 16;

  # Layout and display settings
  active_pane_modifiers = {
    inactive_opacity = 0.8;
  };
  centered_layout = {
    left_padding = 0.2;
    right_padding = 0.2;
  };
  current_line_highlight = "all";
  project_panel = {
    auto_fold_dirs = false;
    entry_spacing = "standard";
    indent_size = 22;
    scrollbar = {
      show = "never";
    };
  };
  scroll_sensitivity = 1.5;
  scrollbar = {
    axes = {
      horizontal = false;
    };
  };
  soft_wrap = "none";

  # General editor settings
  auto_update = false;
  base_keymap = "VSCode";
  confirm_quit = true;
  extend_comment_on_newline = false;
  load_direnv = "direct";
  private_files = [
    "**/.env*"
    "**/*.pem"
    "**/*.key"
    "**/*.cert"
    "**/*.crt"
    "**/secrets.y.*ml"
  ];
  tab_size = 2;
  tabs = {
    activate_on_close = "history";
    git_status = true;
  };
  telemetry = {
    diagnostics = false;
    metrics = false;
  };
  when_closing_with_no_tabs = "keep_window_open";

  # AI and assistant settings
  agent = {
    always_allow_tool_actions = true;
    default_model = {
      enable_experimental_live_diffs = true;
      enabled = true;
      model = "claude-3-7-sonnet-thinking-latest";
      provider = "zed.dev";
    };
    default_profile = "write";
    default_width = 740;
    editor_model = {
      enabled = true;
      model = "claude-3-7-sonnet-thinking-latest";
      provider = "zed.dev";
    };
    profiles = {
      ask = {
        name = "Ask";
        enable_all_context_servers = true;

        context_servers = {
          mcp-server-context7 = {
            tools = {
              get-library-docs = true;
              resolve-library-id = true;
            };
          };
          mcp-server-github = {
            tools = {
              add_issue_comment = false;
              add_pull_request_review_comment = false;
              create_branch = false;
              create_issue = false;
              create_or_update_file = false;
              create_pull_request = false;
              create_pull_request_review = false;
              create_repository = false;
              fork_repository = false;
              get_code_scanning_alert = true;
              get_commit = true;
              get_file_contents = true;
              get_issue = true;
              get_issue_comments = true;
              get_me = true;
              get_pull_request = true;
              get_pull_request_comments = true;
              get_pull_request_files = true;
              get_pull_request_reviews = true;
              get_pull_request_status = true;
              get_secret_scanning_alert = true;
              list_branches = true;
              list_code_scanning_alerts = true;
              list_commits = true;
              list_issues = true;
              list_pull_requests = true;
              list_secret_scanning_alerts = true;
              merge_pull_request = false;
              push_files = false;
              search_code = true;
              search_issues = true;
              search_repositories = true;
              search_users = true;
              update_issue = false;
              update_pull_request = false;
              update_pull_request_branch = false;
            };
          };
        };

        tools = {
          contents = true;
          copy_path = false;
          create_directory = false;
          delete_path = false;
          diagnostics = true;
          edit_file = false;
          fetch = true;
          find_path = true;
          grep = true;
          list_directory = true;
          move_path = false;
          now = true;
          open = true;
          read_file = true;
          terminal = true;
          thinking = true;
          web_search = true;
        };
      };

      minimal = {
        name = "Minimal";
        enable_all_context_servers = false;

        context_servers = {
          mcp-server-context7 = {
            tools = {
              get-library-docs = true;
              resolve-library-id = true;
            };
          };
        };
      };

      write = {
        name = "Write";
        enable_all_context_servers = true;

        tools = {
          copy_path = true;
          create_directory = true;
          create_file = true;
          delete_path = true;
          diagnostics = true;
          edit_file = true;
          fetch = true;
          find_path = true;
          grep = true;
          list_directory = true;
          move_path = true;
          now = true;
          open = true;
          read_file = true;
          terminal = true;
          thinking = true;
          web_search = true;
        };
      };
    };

    stream_edits = true;
    version = "2";
  };

  context_servers = {
    mcp-server-context7 = {
      command = {
        path = "npx";
        args = [
          "-y"
          "@upstash/context7-mcp@latest"
        ];
      };
    };

    mcp-server-github =
      let
        github-mcp-server-wrapped = pkgs.writeShellScriptBin "github-mcp-server-wrapped" ''
          export GITHUB_PERSONAL_ACCESS_TOKEN=$(cat ${config.sops.secrets.github_token.path})
          ${pkgs.github-mcp-server}/bin/github-mcp-server "$@"
        '';
      in
      {
        command = {
          path = "${github-mcp-server-wrapped}/bin/github-mcp-server-wrapped";
          args = [ "stdio" ];
        };
      };
  };

  features = {
    edit_prediction_provider = "zed";
  };

  edit_predictions.mode = "subtle";

  # Git settings
  git = {
    inline_blame = {
      delay_ms = 1800;
      enabled = true;
    };
  };

  # Language specific settings
  languages = {
    HTML = {
      language_servers = [ "vscode-html-language-server" ];
    };

    JSONC = {
      preferred_line_length = 100;
    };

    Markdown = {
      language_servers = [ "marksman" ];
    };

    Nix = {
      language_servers = [ "nixd" ];
    };

    Python = {
      formatter = [ { language_server.name = "ruff"; } ];
      language_servers = [
        "ruff"
        "pylsp"
      ];
      preferred_line_length = 80;
      tab_size = 4;
    };
  };

  # LSP settings
  jupyter.enabled = false;

  lsp = {
    nixd = {
      initialization_options = {
        formatting = {
          command = [
            "nixfmt"
            "--strict"
          ];
        };

        nixpkgs.expr = "import (builtins.getFlake \"flake:nixpkgs\") { }";

        options = {
          darwin.expr = "(builtins.getFlake (\"git+file://\" + toString ~/.dotfiles)).darwinConfigurations.macmini-m4.options";
          home-manager.expr = "(builtins.getFlake (\"git+file://\" + toString ~/.dotfiles)).darwinConfigurations.macmini-m4.options.home-manager.users.type.getSubOptions [ ]";
          nixos.expr = "(builtins.getFlake (\"git+file://\" + toString ~/.dotfiles)).nixosConfigurations.macmini-m1.options";
        };
      };
    };

    pylsp.settings.rope.ropeFolder = null;
    ruff.initialization_options.settings.lineLength = 80;
  };

  # Terminal settings
  terminal = {
    blinking = "on";
    cursor_shape = "bar";
    default_height = 760;
    default_width = 640;

    detect_venv = {
      on = {
        activate_script = "default";
        directories = [
          ".env"
          "env"
          ".venv"
          "venv"
        ];
      };
    };

    dock = "bottom";

    env = {
      GIT_EDITOR = "zeditor --wait";
    };

    font_family = "CaskaydiaCove Nerd Font Mono";
    font_size = 15;
    line_height = "comfortable";
    max_scroll_history_lines = 2000;

    scrollbar = {
      show = "never";
    };

    shell = "system";

    toolbar = {
      breadcrumbs = false;
    };
  };
}
