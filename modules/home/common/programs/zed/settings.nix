{ inputs, pkgs, ... }:
{
  agent = {
    always_allow_tool_actions = true;
    commit_message_model = {
      model = "claude-sonnet-3.7-thinking";
      provider = "copilot_chat";
    };
    default_model = {
      model = "claude-sonnet-4";
      provider = "copilot_chat";
    };
    default_profile = "write";
    default_width = 780;
    enable_feedback = false;
    play_sound_when_agent_done = true;
    profiles = {
      ask = {
        context_servers = {
          mcp-nixos = {
            tools = {
              darwin_info = true;
              darwin_list_options = true;
              darwin_options_by_prefix = true;
              darwin_search = true;
              darwin_stats = true;
              home_manager_info = true;
              home_manager_list_options = true;
              home_manager_options_by_prefix = true;
              home_manager_search = true;
              home_manager_stats = true;
              nixhub_find_version = true;
              nixhub_package_versions = true;
              nixos_channels = true;
              nixos_flakes_search = true;
              nixos_flakes_stats = true;
              nixos_info = true;
              nixos_search = true;
              nixos_stats = true;
            };
          };
          mcp-server-byterover = {
            tools = {
              create-memories = true;
              search-memories = true;
            };
          };
          mcp-server-context7 = {
            tools = {
              get-library-docs = true;
              resolve-library-id = true;
            };
          };
          mcp-server-github = {
            tools = {
              get_code_scanning_alert = false;
              get_commit = true;
              get_file_contents = true;
              get_issue = true;
              get_issue_comments = true;
              get_me = true;
              get_notification_details = true;
              get_pull_request = true;
              get_pull_request_comments = true;
              get_pull_request_files = true;
              get_pull_request_reviews = true;
              get_pull_request_status = true;
              get_secret_scanning_alert = false;
              get_tag = true;
              list_branches = true;
              list_code_scanning_alerts = false;
              list_commits = true;
              list_issues = true;
              list_notifications = false;
              list_pull_requests = true;
              list_secret_scanning_alerts = false;
              list_tags = true;
              search_code = true;
              search_issues = true;
              search_repositories = true;
              search_users = true;
            };
          };
        };
        enable_all_context_servers = false;
        name = "Ask";
        tools = {
          contents = true;
          diagnostics = true;
          fetch = true;
          find_path = true;
          grep = true;
          list_directory = true;
          now = true;
          open = true;
          read_file = true;
          terminal = true;
          thinking = true;
          web_search = true;
        };
      };
      minimal = {
        context_servers = {
          mcp-server-context7 = {
            tools = {
              get-library-docs = true;
              resolve-library-id = true;
            };
          };
        };
        enable_all_context_servers = false;
        name = "Minimal";
      };
      write = {
        enable_all_context_servers = true;
        name = "Write";
        tools = {
          copy_path = true;
          create_directory = true;
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
  };
  agent_font_size = 18;
  auto_update = false;
  auto_update_extensions = {
    copy_path = true;
    create_directory = true;
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
  base_keymap = "VSCode";
  buffer_font_family = "VictorMono Nerd Font";
  buffer_font_size = 15.5;
  buffer_font_weight = 501;
  centered_layout = {
    left_padding = 0.2;
    right_padding = 0.2;
  };
  confirm_quit = true;
  context_servers = {
    mcp-nixos = {
      command = "${pkgs.uv}/bin/uvx";
      args = [ "mcp-nixos" ];
      source = "custom";
    };
    mcp-server-byterover = {
      settings = {
        memory_workspace_key = "pk-br-9a546ebb-be82-480a-93e6-1744a104ff90";
        user_email = "quinn@qeden.dev";
      };
      source = "extension";
    };
    mcp-server-github = {
      settings = {
        github_personal_access_token = inputs.secrets.github-token;
      };
      source = "extension";
    };
  };
  current_line_highlight = "all";
  debugger = {
    button = true;
  };
  edit_predictions = {
    disabled_globs = [ ".env" ];
  };
  extend_comment_on_newline = false;
  features = {
    edit_prediction_provider = "copilot";
  };
  git = {
    inline_blame = {
      delay_ms = 1200;
      enabled = true;
    };
  };
  icon_theme = "Symbols";
  languages = {
    "Git Commit" = {
      allow_rewrap = "anywhere";
      preferred_line_length = 80;
      soft_wrap = "editor_width";
    };
    JSONC = {
      preferred_line_length = 100;
    };
    Just = {
      formatter = [
        {
          external = {
            arguments = [
              "--dump"
              "--justfile=/dev/stdin"
            ];
            command = "just";
          };
        }
      ];
      tab_size = 4;
    };
    Markdown = {
      language_servers = [ "marksman" ];
      remove_trailing_whitespace_on_save = false;
    };
    Nix = {
      edit_predictions_disabled_in = [
        "string"
        "comment"
      ];
      formatter = [
        {
          external = {
            arguments = [ "--strict" ];
            command = "nixfmt";
          };
        }
      ];
      language_servers = [
        "nil"
        "nixd"
      ];
    };
    Python = {
      formatter = [
        {
          language_server = {
            name = "ruff";
          };
        }
      ];
      language_servers = [
        "ruff"
        "pylsp"
      ];
      tab_size = 4;
    };
    TOML = {
      formatter = [
        {
          language_server = {
            name = "toml";
          };
        }
      ];
      language_servers = [
        "toml"
        "!taplo"
      ];
    };
  };
  load_direnv = "direct";
  lsp = {
    nil = {
      nix = {
        binary = "/run/current-system/sw/bin/nix";
        flake = {
          autoArchive = true;
          autoEvalInputs = false;
          nixpkgsInputName = "nixpkgs";
        };
      };
    };
    nixd = {
      initialization_options = {
        options = {
          darwin = {
            expr = "(builtins.getFlake (builtins.toString ~/.dotfiles)).darwinConfigurations.macmini-m4.options";
          };
          home-manager = {
            expr = "(builtins.getFlake (builtins.toString ~/.dotfiles)).nixosConfigurations.macmini-m1.options.home-manager.users.type.getSubOptions []";
          };
          nixos = {
            expr = "(builtins.getFlake (builtins.toString ~/.dotfiles)).nixosConfigurations.macmini-m1.options";
          };
        };
      };
    };
    pylsp = {
      settings = {
        plugins = {
          pycodestyle = {
            enabled = false;
          };
        };
        rope = {
          ropeFolder = null;
        };
      };
    };
    ruff = {
      initialization_options = {
        settings = {
          lineLength = 100;
        };
      };
    };
  };
  lsp_highlight_debounce = 75;
  private_files = [
    "**/.env*"
    "**/*.pem"
    "**/*.key"
    "**/*.cert"
    "**/*.crt"
    "**/secrets.y.*ml"
  ];
  project_panel = {
    auto_fold_dirs = false;
    default_width = 300;
    entry_spacing = "comfortable";
    indent_size = 20;
    scrollbar = {
      show = "never";
    };
  };
  scroll_beyond_last_line = "vertical_scroll_margin";
  scroll_sensitivity = 3;
  scrollbar = {
    axes = {
      horizontal = false;
    };
  };
  show_edit_predictions = true;
  soft_wrap = "none";
  tab_size = 2;
  tabs = {
    activate_on_close = "history";
    git_status = true;
  };
  telemetry = {
    diagnostics = false;
    metrics = false;
  };
  terminal = {
    blinking = "on";
    cursor_shape = "bar";
    default_height = 760;
    default_width = 640;
    detect_venv = {
      on = {
        activate_script = "default";
        directories = [
          ".venv"
          "venv"
        ];
      };
    };
    dock = "bottom";
    env = {
      GIT_EDITOR = "zed-preview --wait";
    };
    font_family = "VictorMono Nerd Font Mono";
    font_size = 15;
    font_weight = 500;
    line_height = "comfortable";
    max_scroll_history_lines = 2000;
    scrollbar = {
      show = "never";
    };
    shell = "system";
    toolbar = {
      breadcrumbs = false;
    };
    working_directory = "current_project_directory";
  };
  theme = {
    dark = "Azutiku Dark  (with italics)";
    light = "Aylin";
    mode = "dark";
  };
  ui_font_family = "SF Pro Text";
  ui_font_size = 16;
  use_system_path_prompts = false;
  use_system_prompts = false;
  vertical_scroll_margin = 8;
  when_closing_with_no_tabs = "keep_window_open";
}
