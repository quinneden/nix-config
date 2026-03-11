{
  status_bar = {
    cursor_position_button = true;
  };
  title_bar = {
    show_branch_icon = true;
    show_onboarding_banner = true;
    show_user_picture = true;
    show_menus = false;
  };
  zoomed_padding = true;
  active_pane_modifiers = { };
  bottom_dock_layout = "full";
  seed_search_query_from_cursor = "always";
  inlay_hints = {
    enabled = false;
    show_other_hints = false;
    show_value_hints = false;
    show_parameter_hints = false;
  };
  minimap = {
    show = "never";
  };
  vim_mode = false;
  auto_install_extensions = {
    basher = true;
    dockerfile = true;
    env = true;
    git-firefly = true;
    github-theme = true;
    html = true;
    ini = true;
    just = true;
    log = true;
    make = true;
    mcp-server-context7 = true;
    mcp-server-github = true;
    nix = true;
    starlark = true;
    symbols = true;
    tombi = true;
    toml = true;
    xml = true;
  };
  agent_servers = {
    Amp = {
      type = "custom";
      command = "bunx";
      args = [ "amp-acp" ];
    };
  };
  agent_ui_font_size = 14;
  agent = {
    tool_permissions = {
      default = "allow";
    };
    use_modifier_to_send = true;
    inline_assistant_model = {
      provider = "zed.dev";
      model = "claude-sonnet-4-6";
    };
    default_model = {
      effort = "high";
      enable_thinking = true;
      model = "claude-opus-4-6";
      provider = "zed.dev";
    };
    commit_message_model = {
      model = "claude-sonnet-4-6";
      provider = "zed.dev";
    };
    thread_summary_model = {
      model = "gemini-3-flash";
      provider = "zed.dev";
    };
    play_sound_when_agent_done = true;
    default_profile = "ask";
    default_width = 780;
    enable_feedback = false;
    profiles = {
      ask = {
        name = "Ask";
        enable_all_context_servers = false;
        tools = {
          project_notifications = true;
          terminal = false;
          contents = true;
          diagnostics = true;
          fetch = true;
          list_directory = true;
          now = true;
          find_path = true;
          read_file = true;
          open = true;
          grep = true;
          thinking = true;
          web_search = true;
        };
        context_servers = {
          serena-context-server = {
            tools = {
              read_memory = true;
              onboarding = true;
              list_memories = true;
              list_dir = true;
              jet_brains_find_referencing_symbols = false;
              insert_before_symbol = false;
              insert_at_line = false;
              insert_after_symbol = false;
              initial_instructions = true;
              remove_project = false;
              rename_symbol = false;
              replace_lines = false;
              replace_symbol_body = false;
              restart_language_server = true;
              search_for_pattern = true;
              summarize_changes = true;
              switch_modes = true;
              think_about_collected_information = true;
              think_about_task_adherence = true;
              think_about_whether_you_are_done = true;
              write_memory = true;
            };
          };
          mcp-server-gitlab = {
            tools = {
              create_branch = false;
              push_files = false;
              create_repository = false;
              create_or_update_file = false;
              create_merge_request = false;
              create_issue = false;
              fork_repository = false;
              get_file_contents = true;
              search_repositories = true;
            };
          };
          mcp-nixos = {
            tools = {
              nixos_stats = true;
              nixos_search = true;
              nixos_info = true;
              nixos_flakes_stats = true;
              nixos_flakes_search = true;
              nixos_channels = true;
              nixhub_package_versions = true;
              nixhub_find_version = true;
              home_manager_stats = true;
              home_manager_search = true;
              home_manager_options_by_prefix = true;
              home_manager_list_options = true;
              home_manager_info = true;
              darwin_stats = true;
              darwin_search = true;
              darwin_options_by_prefix = true;
              darwin_list_options = true;
              darwin_info = true;
            };
          };
          mcp-server-context7 = {
            tools = {
              resolve-library-id = true;
              get-library-docs = true;
            };
          };
          mcp-server-github = {
            tools = {
              get_job_logs = true;
              get_latest_release = true;
              get_release_by_tag = true;
              list_gists = true;
              list_releases = true;
              add_comment_to_pending_review = false;
              search_pull_requests = true;
              search_orgs = true;
              get_pull_request_diff = true;
              add_pull_request_review_comment_to_pending_review = false;
              add_issue_comment = false;
              list_tags = true;
              list_notifications = true;
              get_tag = true;
              get_notification_details = true;
              search_users = true;
              search_repositories = true;
              search_issues = true;
              search_code = true;
              list_secret_scanning_alerts = false;
              list_pull_requests = true;
              list_issues = true;
              list_commits = true;
              list_code_scanning_alerts = false;
              list_branches = true;
              get_secret_scanning_alert = false;
              get_pull_request_status = true;
              get_pull_request_reviews = true;
              get_pull_request_files = true;
              get_pull_request_comments = true;
              get_pull_request = true;
              get_me = true;
              get_issue_comments = true;
              get_issue = true;
              get_file_contents = true;
              get_commit = true;
              get_code_scanning_alert = false;
            };
          };
        };
      };
      write = {
        default_model = {
          provider = "zed.dev";
          model = "claude-sonnet-4-thinking";
        };
        name = "Write";
        enable_all_context_servers = true;
      };
    };
  };
  auto_update = true;
  base_keymap = "VSCode";
  confirm_quit = true;
  current_line_highlight = "all";
  extend_comment_on_newline = false;
  load_direnv = "shell_hook";
  soft_wrap = "none";
  tab_size = 2;
  when_closing_with_no_tabs = "keep_window_open";
  context_servers = {
    mcp-server-context7 = {
      enabled = true;
      remote = false;
      settings = {
        context7_api_key = "ctx7sk-d137bea6-adb7-4101-be88-c62da303f43f";
      };
    };
    mcp-nixos = {
      enabled = true;
      command = "uvx";
      args = [ "mcp-nixos" ];
    };
    mcp-server-github = {
      enabled = true;
      settings = {
        github_personal_access_token = "";
      };
    };
  };
  show_edit_predictions = true;
  edit_predictions = {
    provider = "zed";
    mode = "subtle";
    disabled_globs = [
      ".env"
      ".lock"
    ];
  };
  buffer_font_family = "VictorMono Nerd Font";
  buffer_font_size = 14;
  buffer_font_features = {
    calt = true;
    dlig = true;
    zero = true;
    palt = true;
  };
  buffer_font_weight = 399;
  ui_font_family = "SF Pro Text";
  ui_font_size = 14.5;
  ui_font_weight = 350;
  git = {
    blame = {
      show_avatar = false;
    };
    inline_blame = {
      show_commit_summary = false;
      delay_ms = 800;
      enabled = true;
    };
  };
  icon_theme = {
    mode = "dark";
    light = "Symbols Icon Theme";
    dark = "Symbols Icon Theme";
  };
  languages = {
    "Shell Script" = {
      formatter = {
        external = {
          command = "shfmt";
        };
      };
    };
    C = {
      enable_language_server = false;
    };
    Dockerfile = {
      tab_size = 4;
    };
    "Git Commit" = {
      allow_rewrap = "anywhere";
      soft_wrap = "none";
      preferred_line_length = 80;
      show_wrap_guides = true;
      wrap_guides = [ 80 ];
    };
    Go = {
      formatter = {
        external = {
          command = "gofmt";
        };
      };
      language_servers = [ "delv" ];
    };
    HTML = {
      language_servers = [
        "vscode-html-language-server"
        "!superhtml"
      ];
    };
    "HTML+ERB" = { };
    JSONC = {
      preferred_line_length = 100;
    };
    Just = {
      formatter = [
        {
          external = {
            command = "just";
            arguments = [
              "--dump"
              "--justfile=/dev/stdin"
            ];
          };
        }
      ];
      tab_size = 4;
    };
    Markdown = {
      remove_trailing_whitespace_on_save = false;
      soft_wrap = "editor_width";
    };
    Nix = {
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
        "basedpyright"
        "ruff"
        "ty"
      ];
      tab_size = 4;
    };
    Rust = {
      tab_size = 4;
      show_edit_predictions = false;
    };
    TOML = {
      language_servers = [
        "tombi"
        "toml"
        "!taplo"
      ];
      formatter = [
        {
          language_server = {
            name = "tombi";
          };
        }
      ];
    };
  };
  drop_target_size = 0.3;
  file_types = {
    Dockerfile = [
      "Containerfile"
      "Containerfile-*"
      "Containerfile.*"
      "Dockerfile-*"
      "Dockerfile.*"
    ];
    Nix = [ "*.nix.bck" ];
  };
  lsp_highlight_debounce = 75;
  lsp = {
    bash-language-server = {
      settings = {
        shfmt = {
          spaceRedirects = true;
          simplifyCode = true;
        };
      };
    };
    nil = {
      initialization_options = {
        formatting = {
          command = [
            "nixfmt"
            "--strict"
          ];
        };
      };
      settings = {
        nix = {
          binary = "/nix/var/nix/profiles/default/bin/nix";
          flake = {
            autoArchive = true;
            autoEvalInputs = false;
            nixpkgsInputName = "nixpkgs";
          };
        };
      };
    };
    nixd = {
      binary = {
        path = "nixd";
        arguments = [ "--semantic-tokens" ];
      };
      settings = {
        options = {
          home-manager = {
            expr = "let flake = builtins.getFlake (builtins.toString ./.); in if flake ? \"darwinConfigurations\" then let attrNames = builtins.attrNames flake.darwinConfigurations; in if (builtins.length attrNames) > 0 then ((flake.darwinConfigurations.\${builtins.elemAt attrNames 0}.options.home-manager.users.type.getSubOptions []) or {}) else {} else {}";
          };
          flake-parts = {
            expr = "let flake = builtins.getFlake (builtins.toString ./.); in if flake ? debug then debug.options else {}";
          };
        };
      };
    };
    basedpyright = {
      settings = {
        "basedpyright.analysis" = {
          diagnosticMode = "openFilesOnly";
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
  jupyter = {
    enabled = false;
  };
  private_files = [
    "**/*.pem"
    "**/*.key"
    "**/*.cert"
    "**/*.crt"
    "**/secrets.y.*ml"
  ];
  git_panel = {
    dock = "left";
    default_width = 300;
  };
  project_panel = {
    folder_icons = true;
    file_icons = true;
    auto_fold_dirs = false;
    entry_spacing = "standard";
    hide_root = true;
    indent_size = 14;
    scrollbar = {
      show = "auto";
    };
    default_width = 250;
    indent_guides = {
      show = "always";
    };
    sticky_scroll = true;
  };
  file_finder = {
    include_ignored = "smart";
  };
  vertical_scroll_margin = 8;
  scroll_beyond_last_line = "vertical_scroll_margin";
  scroll_sensitivity = 3;
  scrollbar = {
    show = "auto";
    selected_text = false;
    axes = {
      horizontal = false;
    };
  };
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
    dock = "bottom";
    env = {
      EDITOR = "zed --wait";
      GIT_EDITOR = "zed --wait";
    };
    font_family = "VictorMono Nerd Font";
    font_size = 14;
    font_weight = 400;
    line_height = "standard";
    max_scroll_history_lines = 10000;
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
    dark = "GitHub Dark Dimmed";
    light = "One Light";
    mode = "dark";
  };
  use_system_path_prompts = false;
  use_system_prompts = false;
  centered_layout = {
    left_padding = 0.2;
    right_padding = 0.2;
  };
  rounded_selection = true;
  autosave = "on_window_change";
  use_podman = true;
  sticky_scroll = {
    enabled = true;
  };
  session = {
    trust_all_worktrees = true;
  };
  selection_highlight = false;
  search = {
    button = false;
  };
}
