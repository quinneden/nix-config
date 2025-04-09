{
  hostname,
  inputs,
  nixosModules,
  pkgs,
  ...
}:
{
  imports = [
    inputs.lix-module.nixosModules.default
    inputs.nixos-apple-silicon.nixosModules.default
    inputs.sops-nix.nixosModules.default

    ./hardware-configuration.nix
    "${nixosModules}/common"
    "${nixosModules}/desktop/hyprland"
    "${nixosModules}/services/sops"
  ];

  hardware = {
    asahi = {
      enable = true;
      setupAsahiSound = false;
      useExperimentalGPUDriver = true;
      extractPeripheralFirmware = true;
      peripheralFirmwareDirectory = pkgs.fetchzip {
        url = "https://f.qeden.me/fw/asahi_fw_2025-1-15.tgz";
        hash = "sha256-5FdsoUJZqHLSecJpst95418kFTouaxo4wmC5rEXskMk=";
      };
    };
  };

  # Set hostname
  networking.hostName = hostname;

  system.stateVersion = "25.05";
}
