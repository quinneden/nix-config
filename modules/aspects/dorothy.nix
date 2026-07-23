{ den, self, ... }:

{
  den.aspects.dorothy = {
    includes = [
      den.aspects.asahi
      den.aspects.ghostty
      den.aspects.hyprland
      den.aspects.noctalia
      den.aspects.zen
    ];

    _.to-users.homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        nautilus
        sf-pro-font
      ];
    };

    nixos = {
      boot = {
        consoleLogLevel = 0;
        initrd.availableKernelModules = [
          "usb_storage"
          "sdhci_pci"
        ];

        initrd.verbose = false;
        loader.efi.canTouchEfiVariables = false;
        loader.systemd-boot.enable = true;
        loader.timeout = 1;
        tmp.cleanOnBoot = true;
        kernelParams = [
          "appledrm.show_notch=1"
          "quiet"
          "rd.systemd.show_status=false"
          "rd.udev.log_level=3"
          "splash"
          "udev.log_priority=3"
        ];
      };

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/55a94650-7105-496d-9c93-50c3edfbf870";
          fsType = "btrfs";
          options = [
            "compress=zstd"
            "subvol=@"
          ];
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/BFF5-1CF8";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };

        "/home" = {
          device = "/dev/disk/by-uuid/55a94650-7105-496d-9c93-50c3edfbf870";
          fsType = "btrfs";
          options = [
            "compress=zstd"
            "subvol=@home"
          ];
        };

        "/nix" = {
          device = "/dev/disk/by-uuid/55a94650-7105-496d-9c93-50c3edfbf870";
          fsType = "btrfs";
          options = [
            "compress=zstd"
            "noatime"
            "subvol=@nix"
          ];
        };
      };

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      i18n.defaultLocale = "en_US.UTF-8";

      networking = {
        networkmanager.wifi.backend = "iwd";
        wireless.enable = false;
        wireless.iwd.enable = true;
      };

      nixpkgs = {
        config.allowUnfree = true;
        overlays = [ self.overlays.default ];
      };

      security = {
        polkit.enable = true;
        sudo.wheelNeedsPassword = false;
      };

      services = {
        accounts-daemon.enable = true;
        devmon.enable = true;
        greetd.enable = true;
        gvfs.enable = true;
        libinput.enable = true;

        logind.settings.Login = {
          HandleLidSwitch = "suspend";
          HandleLidSwitchExternalPower = "ignore";
          HandlePowerKey = "ignore";
        };

        openssh.enable = true;
        power-profiles-daemon.enable = true;
        printing.enable = false;
        sysprof.enable = true;
        udisks2.enable = true;
        upower.enable = true;
      };

      time.timeZone = "America/Los_Angeles";

      zramSwap = {
        enable = true;
        memoryPercent = 100;
      };
    };
  };
}
