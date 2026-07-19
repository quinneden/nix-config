{ inputs, ... }:

{
  den.aspects.noctalia = {
    nixos = { pkgs, ... }: {
      imports = [
        inputs.noctalia.nixosModules.default
        inputs.noctalia-greeter.nixosModules.default
      ];

      programs = {
        noctalia = {
          enable = true;
          recommendedServices.enable = true;
          systemd.enable = true;
        };

        noctalia-greeter = {
          enable = true;
          greeter-args = "";
          settings = {
            cursor = {
              path = "${pkgs.phinger-cursors}/share/icons";
              size = 24;
              theme = "phinger-cursors-dark";
            };

            keyboard.layout = "us";
          };
        };
      };
    };

    _.to-users = {
      homeManager = {
        imports = [ inputs.noctalia.homeModules.default ];

        programs.noctalia = {
          enable = true;
          package = null;
          settings = {
            accessibility = {
              high_contrast = false;
              ui_scale = 1;
            };

            audio = {
              enable_overdrive = false;
              enable_sounds = false;
              notification_sound = "";
              sound_volume = 0.5;
              volume_change_sound = "";
            };

            backdrop = {
              blur_intensity = 0.5;
              enabled = false;
              tint_intensity = 0.3;
            };

            bar = {
              main = {
                auto_hide = false;
                background_opacity = 1;
                capsule = false;
                center = [ "clock" ];
                end = [
                  "media"
                  "tray"
                  "notifications"
                  "clipboard"
                  "network"
                  "bluetooth"
                  "volume"
                  "brightness"
                  "battery"
                  "control-center"
                  "session"
                ];

                margin_h = 180;
                margin_v = 10;
                padding = 14;
                position = "top";
                radius = 12;
                reserve_space = true;
                scale = 1;
                shadow = true;
                start = [
                  "launcher"
                  "wallpaper"
                  "workspaces"
                ];

                thickness = 34;
                widget_spacing = 6;
              };
            };

            brightness.enable_ddcutil = false;
            desktop_widgets.enabled = false;
            dock = {
              active_monitor_only = false;
              active_opacity = 1;
              active_scale = 1;
              auto_hide = false;
              background_opacity = 0.88;
              cross_axis_padding = 8;
              enabled = false;
              icon_size = 48;
              inactive_opacity = 0.85;
              inactive_scale = 0.85;
              item_spacing = 6;
              launcher_icon = "grid-dots";
              launcher_position = "none";
              magnification = true;
              magnification_scale = 1.45;
              main_axis_padding = 16;
              margin_h = 0;
              margin_v = 8;
              pinned = [ ];
              position = "bottom";
              radius = 16;
              radius_bottom_left = 16;
              radius_bottom_right = 16;
              radius_top_left = 16;
              radius_top_right = 16;
              reserve_space = true;
              shadow = true;
              show_dots = false;
              show_instance_count = true;
              show_running = true;
            };

            hooks.battery_low_percent_threshold = 10;
            idle = {
              behavior = {
                lock = {
                  action = "lock";
                  enabled = false;
                  timeout = 600;
                };

                screen-off = {
                  action = "screen_off";
                  enabled = false;
                  timeout = 660;
                };
              };
            };

            keybinds = {
              cancel = [ "escape" ];
              down = [ "down" ];
              left = [ "left" ];
              right = [ "right" ];
              tab_next = [ "tab" ];
              tab_previous = [ "shift+iso_left_tab" ];
              up = [ "up" ];
              validate = [
                "return"
                "kp_enter"
                "space"
              ];
            };

            location = {
              address = "";
              auto_locate = false;
            };

            lockscreen = {
              blur_intensity = 0.5;
              blurred_desktop = false;
              enabled = true;
              tint_intensity = 0.3;
            };

            nightlight = {
              enabled = false;
              force = false;
              temperature_day = 6500;
              temperature_night = 4000;
            };

            notification = {
              background_opacity = 0.97;
              enable_daemon = true;
              layer = "top";
              offset_x = 20;
              offset_y = 8;
              scale = 1;
              show_actions = true;
              show_app_name = true;
            };

            osd = {
              background_opacity = 0.97;
              kinds = {
                bluetooth = true;
                brightness = true;
                caffeine = true;
                dnd = true;
                keyboard_layout = true;
                lock_keys = true;
                nightlight = true;
                power_profile = true;
                privacy = true;
                volume = true;
                volume_input = true;
                volume_output = true;
                wifi = true;
              };

              offset_x = 20;
              offset_y = 8;
              orientation = "horizontal";
              position = "top_right";
              position_vertical = "top_center";
              scale = 1;
            };

            shell = {
              animation = {
                enabled = true;
                speed = 1;
              };

              clipboard_auto_paste = "auto";
              clipboard_enabled = true;
              clipboard_history_max_entries = 100;
              clipboard_image_action_command = "";
              corner_radius_scale = 1;
              date_format = "%A, %x";
              font_family = "sans-serif";
              launcher = {
                app_grid = false;
                categories = true;
                compact = false;
                fetch_exchange_rates = true;
                provider_prefix = "/";
                providers = {
                  calculator.global = true;
                  calculator.prefix = "";
                  emoji.prefix = "emo";
                  session.global = false;
                  session.prefix = "session";
                  wallpaper.prefix = "wall";
                  windows.prefix = "win";
                };

                show_icons = true;
                sort_by_usage = true;
              };

              middle_click_opens_widget_settings = true;
              mpris.blacklist = [ ];
              offline_mode = false;
              panel = {
                borders = true;
                clipboard_placement = "centered";
                control_center_placement = "attached";
                launcher_placement = "centered";
                open_near_click_clipboard = false;
                open_near_click_control_center = false;
                open_near_click_launcher = false;
                open_near_click_session = false;
                open_near_click_wallpaper = false;
                session_placement = "attached";
                shadow = true;
                transparency_mode = "solid";
                wallpaper_placement = "attached";
              };

              password_style = "default";
              polkit_agent = false;
              privacy = {
                cam_filter_regex = "";
                mic_filter_regex = "";
                screen_filter_regex = "";
              };

              settings_show_advanced = false;
              shadow = {
                alpha = 0.55;
                direction = "down";
              };

              shared_gl_context = true;
              show_location = true;
              telemetry_enabled = false;
              time_format = "{:%H:%M}";
            };

            system = {
              monitor = {
                cpu_poll_seconds = 2;
                disk_poll_seconds = 10;
                enabled = true;
                gpu_poll_seconds = 5;
                memory_poll_seconds = 2;
                network_poll_seconds = 3;
              };
            };

            theme = {
              builtin = "Noctalia";
              mode = "dark";
              pure_black_dark = false;
              source = "builtin";
              templates = {
                builtin_ids = [ ];
                community_ids = [ ];
                enable_builtin_templates = true;
                enable_community_templates = true;
              };
            };

            wallpaper = {
              automation = {
                enabled = false;
                interval_minutes = 0;
                order = "random";
                recursive = true;
              };

              default.path = "";
              directory = "~/Pictures/Wallpapers";
              directory_dark = "";
              directory_light = "";
              edge_smoothness = 0.3;
              enabled = true;
              fill_color = "";
              fill_mode = "crop";
              transition = [
                "fade"
                "wipe"
                "disc"
                "stripes"
                "zoom"
                "honeycomb"
              ];

              transition_duration = 1500;
              transition_on_startup = false;
            };

            weather = {
              effects = true;
              enabled = false;
              refresh_minutes = 30;
              unit = "celsius";
            };
          };
        };
      };
    };
  };
}
