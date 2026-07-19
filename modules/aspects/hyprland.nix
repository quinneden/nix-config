{
  den.aspects.hyprland = {
    nixos = {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };
    };

    _.to-users = {
      homeManager = {
        xdg = {
          configFile."uwsm/env".text = ''
            export XCURSOR_SIZE="24"
          '';

          portal.config.common.default = [ "hyprland" ];
        };

        wayland.windowManager.hyprland = {
          enable = true;
          package = null;
          extraConfig = ''
            local fileManager = "nautilus"
            local lmb = "mouse:272"
            local terminal = "ghostty"
            local mainMod = "SUPER"

            local ipc = "noctalia msg "
            hl.bind(mainMod .. "+ Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
            hl.bind(mainMod .. "+ S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
            hl.bind(mainMod .. "+ comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
            hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher"))

            hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"))
            hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"))
            hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))

            hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"))
            hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))

            hl.bind(mainMod .. " + " .. lmb, hl.dsp.window.drag(), { mouse = true, drag = true })
            hl.bind(mainMod .. " + " .. lmb, hl.dsp.window.float(), { mouse = true, click = true })

            local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
            closeWindowBind:set_enabled(true)

            hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
            hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
            hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
            -- hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
            hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
            hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

            -- Move focus with mainMod + arrow keys
            hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
            hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
            hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
            hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

            -- Switch workspaces with mainMod + [0-9]
            -- Move active window to a workspace with mainMod + SHIFT + [0-9]
            for i = 1, 10 do
              local key = i % 10 -- 10 maps to key 0
              hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
              hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
            end

            hl.config({
              cursor = {
                hide_on_key_press = true,
              }

              decoration = {
                rounding = 20,
                rounding_power = 2,

                shadow = {
                  enabled = true,
                  range = 4,
                  render_power = 3,
                  color = 0xee1a1a1a,
                },

                blur = {
                  enabled = true,
                  size = 3,
                  passes = 2,
                  vibrancy = 0.1696,
                },
              },

              dwindle = {
                preserve_split = true,
              },

              general = {
                gaps_in = 5,
                gaps_out = 10,
                layout = "dwindle",
                resize_on_border = true,
              },

              input = {
                follow_mouse = 2,
                kb_layout    = "us",
                kb_options   = "caps:swapescape",
                sensitivity  = 0.1,

                touchpad     = {
                  clickfinger_behavior = true,
                  disable_while_typing = true,
                  natural_scroll = true,
                  tap_to_click = false,
                },
              },

              misc = {
                disable_hyprland_logo   = true,
                force_default_wallpaper = -1,
              },
            })

            hl.gesture({
              fingers = 3,
              direction = "horizontal",
              action = "workspace"
            })

            hl.layer_rule({
              name = "noctalia",
              match = {
                namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
              },
              no_anim = true,
              ignore_alpha = 0.5,
              blur = true,
              blur_popups = true,
            })

            hl.monitor({
              output   = "",
              mode     = "preferred",
              position = "auto",
              scale    = "auto",
            })

            hl.on("hyprland.start", function()
              hl.exec_cmd("noctalia")
            end)

            hl.window_rule({
              match = { class = "dev.noctalia.Noctalia" },
              float = true,
              size = { 1080, 920 },
            })
            hl.window_rule({
              name        = "no-gaps-wtv1",
              match       = { float = false, workspace = "w[tv1]" },
              border_size = 0,
              rounding    = 0,
            })
            hl.window_rule({
              name        = "no-gaps-f1",
              match       = { float = false, workspace = "f[1]" },
              border_size = 0,
              rounding    = 0,
            })
            hl.window_rule({
              name           = "suppress-maximize-events",
              match          = { class = ".*" },
              suppress_event = "maximize",
            })

            -- ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
            -- smart gaps / no gaps when only
            hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
            hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })

            -- TODO: find out correct monitor name
            -- hl.workspace_rule({ workspace = "1", monitor = "DP-1", persistent = true })
            -- hl.workspace_rule({ workspace = "2", monitor = "DP-1", persistent = true })
            -- hl.workspace_rule({ workspace = "3", monitor = "DP-1", persistent = true })
            -- hl.workspace_rule({ workspace = "4", monitor = "DP-1", persistent = true })
            -- hl.workspace_rule({ workspace = "5", monitor = "DP-1", persistent = true })
          '';

          systemd.enable = false;
        };
      };
    };
  };
}
