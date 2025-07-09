{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "usbhid"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/65b89f3d-51f5-4b2b-b287-7df9e34702ab";
    fsType = "btrfs";
    options = [
      "subvol=@"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/65b89f3d-51f5-4b2b-b287-7df9e34702ab";
    fsType = "btrfs";
    options = [
      "subvol=@nix"
      "noatime"
      "compress=zstd"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/65E9-15F3";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/65b89f3d-51f5-4b2b-b287-7df9e34702ab";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "compress=zstd"
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
