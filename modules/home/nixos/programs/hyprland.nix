{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    inputs.marble-shell.packages.${pkgs.system}.astal
    inputs.marble-shell.packages.${pkgs.system}.default
    astal.mpris
    brightnessctl
    pulseaudio # pactl
    qt5.qtwayland
    qt6.qtwayland
    slurp
    swww
  ];

  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome-control-center}/bin/gnome-control-center";
    categories = [ "X-Preferences" ];
    terminal = false;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;

    settings = {
      exec-once = [
        "hyprctl setcursor phinger-cursors-dark 24"
        "uwsm app -- marble && sleep 2 && astal -t launcher"
        # "uwsm app -- marble-launcher"
        "swww-daemon"
      ];

      monitor = [ ",preferred,auto,1,bitdepth,10" ];

      general = {
        allow_tearing = true;
        layout = "dwindle";
        resize_on_border = true;
        # "col.active_border" = "rgba(51a4e7ff)";
      };

      render = {
        explicit_sync = 0;
      };

      misc = {
        disable_splash_rendering = true;
        focus_on_activate = true;
        force_default_wallpaper = 1;
        key_press_enables_dpms = true;
        new_window_takes_over_fullscreen = 2;
        middle_click_paste = false;
        vfr = true;
        vrr = 1;
      };

      input = {
        kb_layout = "us";
        kb_options = "caps:escape";
        repeat_delay = 250;
        repeat_rate = 45;
        numlock_by_default = true;
        follow_mouse = 1;
        sensitivity = 0.2;
        touchpad = {
          clickfinger_behavior = true;
          disable_while_typing = false;
          drag_lock = false;
          natural_scroll = "yes";
          scroll_factor = 0.7;
          tap-to-click = false;
        };
        float_switch_override_focus = 2;
        accel_profile = "custom 0.5 0.000 0.053 0.115 0.189 0.280 0.391 0.525 0.687 0.880 1.108 1.375 1.684 2.040 2.446 2.905 3.422 4.000 4.643 5.355 6.139";
      };

      cursor = {
        hide_on_key_press = true;
        persistent_warps = true;
      };

      binds = {
        allow_workspace_cycles = true;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_create_new = false;
        workspace_swipe_distance = "400";
        workspace_swipe_fingers = "4";
        workspace_swipe_cancel_ratio = 0.7;
      };

      windowrule = [
        "animation fade,    class:(ghostty.hdrop)"
        "center,            class:(ghostty.hdrop)"
        "float,             class:(ghostty.hdrop)"
        "opacity 0.88,      class:(ghostty.hdrop)"
        "size 60% 65%,      class:(ghostty.hdrop)"
        "stayfocused,       class:(ghostty.hdrop)"
        "float,             class:(pinentry-)(.*)"
        "stayfocused,       class:(pinentry-)(.*)"
      ];

      windowrulev2 = [
        "float,          class:(xdg-desktop-portal-gtk), initialTitle:(Open )(File|Folder)"
        "center,         class:(xdg-desktop-portal-gtk), initialTitle:(Open )(File|Folder)"
        "stayfocused,    class:(xdg-desktop-portal-gtk), initialTitle:(Open )(File|Folder)"
        "size 1000 650,  class:(xdg-desktop-portal-gtk), initialTitle:(Open )(File|Folder)"

        "float,          class:(zen), initialTitle:(Library)"
        "center,         class:(zen), initialTitle:(Library)"
        "size 900 1200,  class:(zen), initialTitle:(Library)"

        "float,          class:org.gnome.Nautilus"
        "size 1200 850,  class:org.gnome.Nautilus"
      ];

      bind =
        let
          binding =
            mod: cmd: key: arg:
            "${mod}, ${key}, ${cmd}, ${arg}";
          swap = binding "SUPER SHIFT CTRL" "swapwindow";
          mvfocus = binding "SUPER" "movefocus";
          mvtows = binding "SUPER SHIFT" "movetoworkspace";
          ws = binding "SUPER" "workspace";
          arr = lib.range 1 7;
        in
        [
          "CTRL ALT, Delete, exec, uwsm stop"
          # "CTRL ALT, R,      exec, marble quit; marble"
          # "SUPER, R,         exec, marble-launcher --open"
          # "SUPER, Tab,       exec, marble-launcher ':sh'"
          # ",XF86PowerOff,    exec, marble shutdown"
          # ",XF86MenuKB,      exec, marble lockscreen"
          "CTRL ALT, R,      exec, marble quit; uwsm app -- marble && sleep 2 && astal -t launcher"
          "SUPER, R,         exec, astal -t launcher"
          "SUPER, Tab,       exec, astal eval \"launcher('sh')\""
          ",XF86MenuKB,      exec, astal -t powermenu"

          "SUPER, Return,    exec, ghostty"
          "SUPER CTRL, W,    exec, hdrop -c ghostty.hdrop -- ghostty --class=ghostty.hdrop"
          "SUPER, B,         exec, zen"
          "SUPER, E,         exec, nautilus"

          "SUPER, Q,         killactive"
          "SUPER, G,         togglefloating"
          "SUPER, F,         fullscreen"
          "SUPER, P,         togglesplit"

          (mvfocus "up" "u")
          (mvfocus "down" "d")
          (mvfocus "left" "l")
          (mvfocus "right" "r")
          (swap "up" "u")
          (swap "down" "d")
          (swap "left" "l")
          (swap "right" "r")
        ]
        ++ (map (i: ws (toString i) (toString i)) arr)
        ++ (map (i: mvtows (toString i) (toString i)) arr);

      bindle = [
        ",XF86MonBrightnessUp,   exec, brightnessctl set +5%"
        ",XF86MonBrightnessDown, exec, brightnessctl set  5%-"
        ",XF86AudioRaiseVolume,  exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume,  exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
      ];

      bindl = [
        ",XF86AudioPlay,  exec, astal-mpris play-pause"
        ",XF86AudioStop,  exec, astal-mpris pause"
        ",XF86AudioPause, exec, astal-mpris pause"
        ",XF86AudioPrev,  exec, astal-mpris previous"
        ",XF86AudioNext,  exec, astal-mpris next"
        ",XF86AudioMute,  exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
      ];

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];

      decoration = {
        shadow = {
          range = 11;
          render_power = 0;
          color = "rgba(0,0,0,0.3)";
        };

        # rounding = 8;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
          popups = true;
        };
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
    };
  };
}
