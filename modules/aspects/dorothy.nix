{ den, ... }:

{
  den.aspects.dorothy = {
    includes = [
      den.aspects.asahi
      den.aspects.ghostty
      den.aspects.hyprland
      den.aspects.noctalia
      den.aspects.zen
    ];

    _.to-users.homeManager = { pkgs, ... }: { home.packages = [ pkgs.nautilus ]; };

    nixos = { pkgs, ... }: {
      imports = [ /etc/nixos/hardware-configuration.nix ];

      boot = {
        bootspec.enable = true;
        consoleLogLevel = 0;
        initrd.verbose = false;
        loader.efi.canTouchEfiVariables = false;
        loader.systemd-boot.enable = true;
        loader.timeout = 1;

        m1n1CustomLogo = pkgs.fetchurl {
          url = "https://f.qeden.me/nixos-logomark-white-256x.png";
          hash = "sha256-DiBuefj89zhU6XvOt3RlNlr7Vg1uYynqhLvda6bMSx0=";
        };

        tmp.cleanOnBoot = true;
        kernelParams = [
          "quiet"
          "rd.systemd.show_status=false"
          "rd.udev.log_level=3"
          "splash"
          "udev.log_priority=3"
        ];
      };

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      i18n.defaultLocale = "en_US.UTF-8";
      networking.networkmanager.wifi.backend = "iwd";
      nixpkgs.config.allowUnfree = true;

      services = {
        accounts-daemon.enable = true;
        devmon.enable = true;
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
