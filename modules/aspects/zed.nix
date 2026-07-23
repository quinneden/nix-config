{
  den.aspects.dorothy._.to-users.homeManager = { pkgs, ... }: {
    programs.zed-editor = {
      enable = true;

      extraPackages =
        let
          lualsp = pkgs.runCommand "luals" { nativeBuildInputs = [ pkgs.makeWrapper ]; } ''
            install -Dm755 -t $out/bin ${pkgs.lua-language-server}/bin/lua-language-server
            wrapProgram $out/bin/lua-language-server \
              --set HYPR_STUBS ${pkgs.hyprland}/share/hypr/stubs
          '';
        in
        with pkgs;
        [
          basedpyright
          just
          lualsp
          nerd-fonts.victor-mono
          nil
          nixd
          nixfmt
          package-version-server
          ruff
          shfmt
          tombi
        ];

      extensions = [
        "basher"
        "dockerfile"
        "env"
        "git-firefly"
        "github-theme"
        "html"
        "ini"
        "just"
        "log"
        "make"
        "mcp-server-context7"
        "mcp-server-github"
        "nix"
        "symbols"
        "tombi"
        "toml"
        "xml"
      ];

      mutableUserSettings = true;
      mutableUserKeymaps = true;

      # userSettings = {
      #   status_bar.cursor_position_button = true;
      #   title_bar = {
      #     show_branch_icon = true;
      #     show_onboarding_banner = true;
      #     show_user_picture = true;
      #     show_menus = false;
      #   };
      #   zoomed_padding = true;
      #   bottom_dock_layout = "full";
      #   seed_search_query_from_cursor = "always";
      #   minimap.show = "never";
      #   base_keymap = "VSCode";
      #   confirm_quit = true;
      #   current_line_highlight = "all";
      #   extend_comment_on_newline = false;
      #   load_direnv = "shell_hook";
      #   soft_wrap = "none";
      #   tab_size = 2;
      #   when_closing_with_no_tabs = "keep_window_open";
      #   show_edit_predictions = false;
      #   edit_predictions = {
      #     provider = "zed";
      #     mode = "subtle";
      #     disabled_globs = [
      #       ".env"
      #       ".lock"
      #     ];
      #   };
      #   buffer_font_family = "VictorMono Nerd Font";
      #   buffer_font_size = 14;
      #   buffer_font_features = {
      #     calt = true;
      #     dlig = true;
      #     zero = true;
      #     palt = true;
      #   };
      #   buffer_font_weight = 399;
      #   ui_font_size = 14.5;
      #   ui_font_weight = 350;
      #   git = {
      #     blame = {
      #       show_avatar = false;
      #     };
      #     inline_blame = {
      #       show_commit_summary = false;
      #       delay_ms = 800;
      #       enabled = true;
      #     };
      #   };
      #   icon_theme = {
      #     mode = "dark";
      #     light = "Symbols Icon Theme";
      #     dark = "Symbols Icon Theme";
      #   };
      #   format_on_save = "on";
      #   languages = {
      #     "Shell Script" = {
      #       formatter = {
      #         external = {
      #           command = "shfmt";
      #         };
      #       };
      #     };
      #     C = {
      #       enable_language_server = false;
      #     };
      #     Dockerfile = {
      #       tab_size = 4;
      #     };
      #     "Git Commit" = {
      #       allow_rewrap = "anywhere";
      #       soft_wrap = "none";
      #       preferred_line_length = 80;
      #       show_wrap_guides = true;
      #       wrap_guides = [ 80 ];
      #     };
      #     JSONC = {
      #       preferred_line_length = 100;
      #     };
      #     Just = {
      #       formatter = [
      #         {
      #           external = {
      #             command = "just";
      #             arguments = [
      #               "--dump"
      #               "--justfile=/dev/stdin"
      #             ];
      #           };
      #         }
      #       ];
      #       tab_size = 4;
      #     };
      #     Markdown = {
      #       remove_trailing_whitespace_on_save = false;
      #       soft_wrap = "editor_width";
      #     };
      #     Nix = {
      #       language_servers = [
      #         "nil"
      #         "nixd"
      #       ];
      #     };
      #     Python = {
      #       formatter = [
      #         {
      #           language_server = {
      #             name = "ruff";
      #           };
      #         }
      #       ];
      #       language_servers = [
      #         # "basedpyright"
      #         "ruff"
      #         "ty"
      #       ];
      #       tab_size = 4;
      #     };
      #     Rust = {
      #       tab_size = 4;
      #       show_edit_predictions = false;
      #     };
      #     TOML = {
      #       language_servers = [
      #         "tombi"
      #         "toml"
      #         "!taplo"
      #       ];
      #       formatter = [
      #         {
      #           language_server = {
      #             name = "tombi";
      #           };
      #         }
      #       ];
      #     };
      #   };
      #   drop_target_size = 0.3;
      #   file_types = {
      #     Dockerfile = [
      #       "Containerfile"
      #       "Containerfile-*"
      #       "Containerfile.*"
      #       "Dockerfile-*"
      #       "Dockerfile.*"
      #     ];
      #     Nix = [ "*.nix.bck" ];
      #   };
      #   lsp_highlight_debounce = 75;
      #   lsp = {
      #     bash-language-server = {
      #       settings = {
      #         shfmt = {
      #           spaceRedirects = true;
      #           simplifyCode = true;
      #         };
      #       };
      #     };
      #     nil = {
      #       initialization_options = {
      #         formatting = {
      #           command = [
      #             "nixfmt"
      #             "--strict"
      #           ];
      #         };
      #       };
      #       settings = {
      #         nix = {
      #           flake = {
      #             autoArchive = true;
      #             autoEvalInputs = false;
      #             nixpkgsInputName = "nixpkgs";
      #           };
      #         };
      #       };
      #     };
      #     nixd = {
      #       binary = {
      #         path = "nixd";
      #         arguments = [ "--semantic-tokens" ];
      #       };
      #     };
      #     ruff = {
      #       initialization_options = {
      #         settings = {
      #           lineLength = 100;
      #         };
      #       };
      #     };
      #   };
      #   jupyter = {
      #     enabled = false;
      #   };
      #   private_files = [
      #     "**/*.pem"
      #     "**/*.key"
      #     "**/*.cert"
      #     "**/*.crt"
      #     "**/secrets.y.*ml"
      #   ];
      #   git_panel = {
      #     dock = "left";
      #     default_width = 300;
      #   };
      #   project_panel = {
      #     folder_icons = true;
      #     file_icons = true;
      #     auto_fold_dirs = false;
      #     entry_spacing = "standard";
      #     hide_root = true;
      #     indent_size = 14;
      #     scrollbar = {
      #       show = "auto";
      #     };
      #     default_width = 250;
      #     indent_guides = {
      #       show = "always";
      #     };
      #     sticky_scroll = true;
      #   };
      #   file_finder = {
      #     include_ignored = "smart";
      #   };
      #   vertical_scroll_margin = 8;
      #   scroll_beyond_last_line = "vertical_scroll_margin";
      #   scroll_sensitivity = 3;
      #   scrollbar = {
      #     show = "auto";
      #     selected_text = false;
      #     axes = {
      #       horizontal = false;
      #     };
      #   };
      #   tabs = {
      #     activate_on_close = "history";
      #     git_status = true;
      #   };
      #   telemetry = {
      #     diagnostics = false;
      #     metrics = false;
      #   };
      #   terminal = {
      #     blinking = "on";
      #     cursor_shape = "bar";
      #     default_height = 760;
      #     default_width = 640;
      #     dock = "bottom";
      #     env = {
      #       EDITOR = "zed --wait";
      #       GIT_EDITOR = "zed --wait";
      #     };
      #     font_family = "VictorMono Nerd Font";
      #     font_size = 14;
      #     font_weight = 400;
      #     line_height = "standard";
      #     max_scroll_history_lines = 10000;
      #     scrollbar = {
      #       show = "never";
      #     };
      #     shell = "system";
      #     toolbar = {
      #       breadcrumbs = false;
      #     };
      #     working_directory = "current_project_directory";
      #   };
      #   theme = {
      #     dark = "GitHub Dark Dimmed";
      #     light = "One Light";
      #     mode = "dark";
      #   };
      #   use_system_path_prompts = false;
      #   use_system_prompts = false;
      #   centered_layout = {
      #     left_padding = 0.2;
      #     right_padding = 0.2;
      #   };
      #   rounded_selection = true;
      #   autosave = "on_window_change";
      #   use_podman = true;
      #   sticky_scroll = {
      #     enabled = true;
      #   };
      #   session = {
      #     trust_all_worktrees = true;
      #   };
      #   selection_highlight = false;
      #   search = {
      #     button = false;
      #   };
      # };

      # userKeymaps = import ./keymaps.nix;
    };
  };
}
