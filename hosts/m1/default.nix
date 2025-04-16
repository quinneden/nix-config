{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = (lib.custom.scanPaths ./.) ++ [
    inputs.home-manager.nixosModules.default
    inputs.lix-module.nixosModules.default
    inputs.nixos-apple-silicon.nixosModules.default
    inputs.sops-nix.nixosModules.default
    ../../modules/nixos
  ];

  boot = {
    loader.efi.canTouchEfiVariables = false;
    loader.systemd-boot.enable = true;
    bootspec.enable = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
    tmp.cleanOnBoot = true;
    plymouth.enable = true;

    extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
    kernelModules = [
      "ddcci"
      "ddcci_backlight"
      "i2c-dev"
    ];

    kernelParams = [
      "quiet"
      "splash"
      "vga=current"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    m1n1CustomLogo = pkgs.fetchurl {
      url = "https://f.qeden.me/bootlogo-snowflake-white.png";
      hash = "sha256-6VpPDZSYD57m4LZRPQuOWtR7z70BQ0A2f2jZgjXDiKs=";
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
    i2c.enable = true;
    i2c.group = "i2c";
    asahi = {
      setupAsahiSound = true;
      useExperimentalGPUDriver = true;
      extractPeripheralFirmware = true;
      peripheralFirmwareDirectory = pkgs.fetchzip {
        url = "https://f.qeden.me/fw/asahi_fw_2025-1-15.tgz";
        hash = "sha256-5FdsoUJZqHLSecJpst95418kFTouaxo4wmC5rEXskMk=";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    asahi-bless
    asahi-btsync
    asahi-fwextract
    ddcutil
  ];

  programs.zsh.enable = true;

  time.timeZone = "America/Los_Angeles";

  networking = {
    hostName = "macmini-m1";
    useDHCP = false;
    interfaces.tailscale0.useDHCP = true;
    interfaces.wlan0.useDHCP = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  home-manager = {
    backupFileExtension = "hm-backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.quinn = import ../../modules/home/nixos;
  };

  security.sudo.wheelNeedsPassword = false;
  system.stateVersion = "25.05";
}
