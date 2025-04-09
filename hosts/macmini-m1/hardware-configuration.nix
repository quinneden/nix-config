{ lib, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5fe8128f-165f-4e88-9188-823c61dca13e";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/5fe8128f-165f-4e88-9188-823c61dca13e";
    fsType = "btrfs";
    options = [ "subvol=@nix" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/12CE-A600";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/5fe8128f-165f-4e88-9188-823c61dca13e";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
