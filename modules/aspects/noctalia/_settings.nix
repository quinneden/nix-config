{
  accessibility = {
    ui_scale = 1.05;
  };
  audio = {
    enable_sounds = true;
    sound_volume = 0.5;
  };
  backdrop = {
    blur_intensity = 0.5;
    enabled = false;
    tint_intensity = 0.3;
  };
  bar = {
    main = {
      auto_hide = false;
      background_opacity = 0.75;
      capsule = false;
      center = [ ];
      concave_edge_corners = false;
      end = [
        "tray"
        "clipboard"
        "notifications"
        "battery"
        "network"
        "control-center"
        "clock"
      ];
      margin_ends = 0;
      margin_h = 180;
      margin_v = 10;
      padding = 14;
      position = "top";
      radius = 0;
      reserve_space = true;
      scale = 1;
      shadow = true;
      start = [
        "launcher"
        "wallpaper"
        "workspaces"
      ];
      thickness = 35;
      widget_spacing = 6;
    };
  };
  control_center = {
    sidebar_section = "none";
  };
  desktop_widgets = {
    enabled = false;
  };
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
  hooks = {
    battery_low_percent_threshold = 10;
  };
  idle = {
    behavior = {
      lock = {
        action = "lock";
        enabled = true;
        timeout = 1200;
      };
      screen-off = {
        action = "screen_off";
        enabled = true;
        timeout = 1800;
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
    auto_locate = true;
  };
  lockscreen = {
    blur_intensity = 0.5;
    blurred_desktop = true;
    enabled = true;
    fingerprint = false;
    tint_intensity = 0.3;
  };
  lockscreen_widgets = {
    enabled = false;
    grid = {
      cell_size = 16;
      major_interval = 4;
      visible = true;
    };
    schema_version = 2;
    widget = {
      "lockscreen-login-box@eDP-1" = {
        box_height = 70;
        box_width = 400;
        cx = 864;
        cy = 961;
        output = "eDP-1";
        rotation = 0;
        settings = {
          background_color = "surface_variant";
          background_opacity = 0.88;
          background_radius = 12;
          center_password_text = false;
          input_opacity = 1;
          input_radius = 6;
          show_caps_lock = true;
          show_keyboard_layout = true;
          show_login_button = true;
          show_password_hint = true;
        };
        type = "login_box";
      };
    };
    widget_order = [ "lockscreen-login-box@eDP-1" ];
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
      speed = 1.2;
    };
    clipboard_auto_paste = "auto";
    clipboard_enabled = true;
    clipboard_history_max_entries = 100;
    clipboard_image_action_command = "";
    corner_radius_scale = 1.7;
    date_format = "%a, %h %e";
    font_family = "UbuntuSans NF";
    launcher = {
      app_grid = false;
      categories = true;
      compact = false;
      fetch_exchange_rates = true;
      provider_prefix = "/";
      providers = {
        calculator = {
          global = true;
          prefix = "";
        };
        emoji = {
          prefix = "emo";
        };
        session = {
          global = false;
          prefix = "session";
        };
        wallpaper = {
          prefix = "wall";
        };
        windows = {
          prefix = "win";
        };
      };
      show_icons = true;
      sort_by_usage = true;
    };
    middle_click_opens_widget_settings = true;
    mpris = {
      blacklist = [ ];
    };
    offline_mode = false;
    panel = {
      borders = true;
      clipboard_placement = "centered";
      control_center_placement = "floating";
      launcher_placement = "centered";
      launcher_position = "auto";
      open_near_click_clipboard = false;
      open_near_click_control_center = true;
      open_near_click_launcher = true;
      open_near_click_session = true;
      open_near_click_wallpaper = true;
      session_placement = "floating";
      session_position = "top_right";
      shadow = true;
      transparency_mode = "glass";
      wallpaper_placement = "floating";
    };
    password_style = "default";
    polkit_agent = true;
    session = {
      actions = [
        {
          action = "lock";
          countdown_seconds = 0;
          enabled = true;
          shortcut = "1";
          variant = "default";
        }
        {
          action = "logout";
          countdown_seconds = 0;
          enabled = true;
          shortcut = "2";
          variant = "default";
        }
        {
          action = "reboot";
          countdown_seconds = 0;
          enabled = true;
          shortcut = "4";
          variant = "default";
        }
        {
          action = "shutdown";
          countdown_seconds = 0;
          enabled = true;
          shortcut = "5";
          variant = "destructive";
        }
      ];
    };
    settings_show_advanced = true;
    shadow = {
      alpha = 0.55;
      direction = "down";
    };
    shared_gl_context = true;
    show_location = true;
    telemetry_enabled = false;
    time_format = "{:%-I:%M %p}";
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
    community_palette = "ADW";
    mode = "dark";
    pure_black_dark = false;
    source = "wallpaper";
    templates = {
      builtin_ids = [ ];
      community_ids = [ ];
      enable_builtin_templates = true;
      enable_community_templates = true;
    };
    wallpaper_scheme = "m3-tonal-spot";
  };
  wallpaper = {
    automation = {
      enabled = false;
      interval_minutes = 0;
      order = "random";
      recursive = true;
    };
    default = {
      path = "/home/qeden/.local/wallpapers/creation-of-adam.jpeg";
    };
    directory = "/home/qeden/.local/wallpapers";
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
    enabled = true;
    refresh_minutes = 30;
    unit = "imperial";
  };
  widget = {
    battery = {
      display_mode = "graphic";
      scale = 0.9;
    };
    bluetooth = {
      enabled = false;
    };
    brightness = {
      enabled = false;
    };
    clock = {
      format = "{:%-I:%M %p}";
    };
    control-center = {
      glyph = "adjustments-horizontal";
    };
    network = {
      show_label = false;
    };
    session = {
      enabled = false;
    };
    volume = {
      enabled = false;
    };
  };
}
