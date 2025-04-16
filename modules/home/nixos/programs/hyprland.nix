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
    pulseaudio
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
        "uwsm app marble"
        "uwsm app marble-launcher"
        "swww-daemon"
      ];

      monitor = [ "HDMI-A-1,2560x1440@144,auto,1" ];

      general = {
        layout = "dwindle";
        resize_on_border = true;
        "col.active_border" = "rgb(51a4e7)";
      };

      render = {
        explicit_sync = 0;
      };

      misc = {
        disable_splash_rendering = true;
        focus_on_activate = true;
        force_default_wallpaper = 1;
        new_window_takes_over_fullscreen = 2;
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
          drag_lock = true;
          natural_scroll = "yes";
        };
        float_switch_override_focus = 2;
        accel_profile = "custom 0.5 0.000 0.053 0.115 0.189 0.280 0.391 0.525 0.687 0.880 1.108 1.375 1.684 2.040 2.446 2.905 3.422 4.000 4.643 5.355 6.139";
      };

      binds = {
        allow_workspace_cycles = true;
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_touch = true;
        workspace_swipe_use_r = true;
      };

      # windowrulev2 = [ "float, class:(.*)" ];

      bind =
        let
          binding =
            mod: cmd: key: arg:
            "${mod}, ${key}, ${cmd}, ${arg}";
          mvfocus = binding "SUPER" "movefocus";
          ws = binding "SUPER" "workspace";
          mvtows = binding "SUPER SHIFT" "movetoworkspace";
          arr = lib.range 1 7;
        in
        [
          "CTRL ALT, R, exec,     marble quit; marble"
          "SUPER, R, exec,        marble-launcher --open"
          "SUPER, Tab, exec,      marble-launcher ':h'"
          ",XF86PowerOff, exec,   marble shutdown"
          ",XF86MenuKB, exec,     marble lockscreen"
          "SUPER, Return, exec,   xterm"
          "SUPER, B, exec,        zen"
          "SUPER, E, exec,        xterm -e lf"

          # "ALT, Tab, exec,        hyprctl dispatch focuscurrentorlast; hyprctl dispatch alterzorder top"
          "CTRL ALT, Delete,      exit"
          "SUPER, Q,              killactive"
          "SUPER, G,              togglefloating"
          "SUPER, F,              fullscreen"
          "SUPER, P,              togglesplit"

          (mvfocus "up" "u")
          (mvfocus "down" "d")
          (mvfocus "left" "l")
          (mvfocus "right" "r")
        ]
        ++ (map (i: ws (toString i) (toString i)) arr)
        ++ (map (i: mvtows (toString i) (toString i)) arr);

      bindle = [
        ",XF86MonBrightnessUp,    exec, brightnessctl set +5%"
        ",XF86MonBrightnessDown,  exec, brightnessctl set  5%-"
        ",XF86AudioRaiseVolume,   exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume,   exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
      ];

      bindl = [
        ",XF86AudioPlay,    exec, astal-mpris play-pause"
        ",XF86AudioStop,    exec, astal-mpris pause"
        ",XF86AudioPause,   exec, astal-mpris pause"
        ",XF86AudioPrev,    exec, astal-mpris previous"
        ",XF86AudioNext,    exec, astal-mpris next"
        ",XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
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

        rounding = 8;
        dim_inactive = false;

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
