{ pkgs, ... }:
{
  # nix
  documentation.nixos.enable = false;

  nix.settings = {
    accept-flake-config = true;
    always-allow-substitutes = true;
    extra-experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    warn-dirty = false;
    trusted-users = [ "qeden" ];
  };

  # virtualisation
  virtualisation = {
    podman = {
      enable = true;
      dockerSocket.enable = true;
    };
  };

  # dconf
  programs.dconf.enable = true;

  # packages
  environment.systemPackages = with pkgs; [
    asahi-audio
    asahi-bless
    asahi-btsync
    asahi-fwextract
    asahi-wifisync
    git
    wget
  ];

  # services
  services = {
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
    };
    libinput.enable = true;
    sysprof.enable = true;
    printing.enable = false;
    flatpak.enable = true;
  };

  # ssh
  services.openssh.enable = true;
  # programs.ssh.startAgent = true;

  # network
  networking = {
    hostName = "blanche-nixos";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    wireless.enable = false;
    wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };
  };

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true; # bluetooth percentage
  };

  # swap
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  # asahi
  hardware.asahi = {
    setupAsahiSound = true;
    extractPeripheralFirmware = true;
    peripheralFirmwareDirectory = "${./firmware}";
  };

  # bootloader
  boot = {
    bootspec.enable = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
    tmp.cleanOnBoot = true;
    loader = {
      timeout = 1;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };

    kernelParams = [
      "quiet"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "splash"
      "udev.log_priority=3"
    ];

    # kernelPatches = [
      # {
        # name = "macsmc-power.c support_charge_behavior";
        # patch = pkgs.fetchpatch2 {
          # url = "https://patch-diff.githubusercontent.com/raw/AsahiLinux/linux/pull/435.patch";
          # sha256 = "";
        # };
      # }
    # ];
  };

  xdg.portal = {
  	enable = true;
  	extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "26.05";
}
