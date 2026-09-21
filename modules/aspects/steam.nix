{ inputs, ... }:

{
  den.aspects.steam = {
    nixos = {
      imports = [ inputs.steam-asahi.nixosModules.default ];

      programs.steam-asahi = {
        enable = false;
        backend = "x86-fex";
        # memoryMiB = 6144;
        # vramMiB = 4096;
      };

      users.users.qeden.extraGroups = [ "kvm" ];
    };
  };
}
