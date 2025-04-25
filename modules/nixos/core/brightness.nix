{ pkgs, ... }:
{
  hardware.acpilight.enable = true;

  environment.systemPackages = [
    pkgs.brightnessctl
    pkgs.acpilight
  ];

  # services.udev.extraRules = ''
  #   ACTION=="add", SUBSYSTEM=="backlight" KERNEL=="acpi_video0", RUN+="chgrp video /sys/class/backlight/acpi_video0/brightness"
  #   ACTION=="add", SUBSYSTEM=="backlight" KERNEL=="acpi_video0", RUN+="chmod g+w /sys/class/backlight/acpi_video0/brightness"
  # '';

  boot.kernelParams = [
    "acpi_backlight=native"
    "acpi_backlight=vendor"
    "acpi_backlight=video"
  ];
}
