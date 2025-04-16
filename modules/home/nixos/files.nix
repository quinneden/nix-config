{
  xdg.configFile."uwsm/env".text = ''
    "export ANKI_WAYLAND=1"
    "export AQ_DRM_DEVICES=/dev/dri/card1:/dev/dri/card0"
    "export CLUTTER_BACKEND=wayland"
    "export ELECTRON_OZONE_PLATFORM_HINT=auto"
    "export GSK_RENDERER=vulkan"
    "export GDK_BACKEND=wayland"
    "export MOZ_ENABLE_WAYLAND=1"
    "export NIXOS_OZONE_WL=1"
    "export SDL_VIDEODRIVER=wayland"
  '';
}
