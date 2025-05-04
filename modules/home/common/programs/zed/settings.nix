{
  config,
  lib,
  inputs,
  package,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv) isLinux;
in
{
  assistant = {
    default_model = {
      enabled = true;
      model = "claude-3-7-sonnet-thinking-latest";
      provider = "zed.dev";
    };
    editor_model = {
      enabled = true;
      model = "claude-3-7-sonnet-latest";
      provider = "zed.dev";
    };
    version = "2";
  };

  auto_update = false;
  base_keymap = "VSCode";

  buffer_font_family = "CaskaydiaCove Nerd Font";
  buffer_font_size = if isLinux then 16 else 15;
  buffer_line_height = {
    custom = 1.6;
  };

  centered_layout = {
    left_padding = 0.2;
    right_padding = 0.2;
  };

  confirm_quit = true;

  context_servers = {
    Context7 = {
      command = {
        path = "${pkgs.nodejs}/bin/npx";
        args = [
          "-y"
          "@upstash/context7-mcp@latest"
        ];
      };
      settings = { };
    };
    mcp-server-github = {
      command = {
        path = "${pkgs.github-mcp-server}/bin/github-mcp-server";
        args = [ "stdio" ];
      };
      settings = {
        github_personal_access_token = inputs.secrets.git.token;
      };
    };
  };

  current_line_highlight = "all";

  edit_predictions = {
    disabled_globs = [ "secrets.yml,secrets.yaml" ];
    enabled_in_assistant = false;
    mode = "subtle";
  };

  extend_comment_on_newline = false;

  features = {
    edit_prediction_provider = "zed";
  };

  git = {
    inline_blame = {
      delay_ms = 1800;
      enabled = true;
    };
  };

  icon_theme = "Symbols";

  jupyter.enabled = false;

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
      preferred_line_length = 80;
      tab_size = 4;
    };
  };

  load_direnv = "direct";

  lsp = {
    nixd = {
      initialization_options = {
        formatting = {
          command = [
            "nixfmt"
            "--strict"
          ];
        };
        nixpkgs = {
          expr = "import (builtins.getFlake \"flake:nixpkgs\") { }";
        };
        options = {
          darwin = {
            expr = "(builtins.getFlake (\"git+file://\" + toString ~/.dotfiles)).darwinConfigurations.macmini-m4.options";
          };
          home-manager = {
            expr = "(builtins.getFlake (\"git+file://\" + toString ~/.dotfiles)).darwinConfigurations.macmini-m4.options.home-manager.users.type.getSubOptions []";
          };
          nixos = {
            expr = "(builtins.getFlake (\"git+file://\" + toString ~/.dotfiles)).nixosConfigurations.macmini-m1.options";
          };
        };
      };
    };
    pylsp = {
      settings = {
        rope = {
          ropeFolder = null;
        };
      };
    };
    ruff = {
      initialization_options = {
        settings = {
          lineLength = 80;
        };
      };
    };
  };

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
          ".env"
          "env"
          ".venv"
          "venv"
        ];
      };
    };
    dock = "bottom";
    env = {
      EDITOR = "${lib.getExe package} --wait";
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

  theme = {
    dark = "Aylin";
    light = "Aylin";
    mode = "dark";
  };

  ui_font_family = ".SystemUIFont";
  ui_font_size = 17;
  when_closing_with_no_tabs = "keep_window_open";
}
