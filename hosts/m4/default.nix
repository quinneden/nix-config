{ inputs, ... }:

{
  imports = [
    ../../modules/external/nh-darwin.nix
    ../../modules/optional/nh.nix
    ../../modules/optional/virby.nix
    ./brew.nix
    ./home.nix
    ./nix.nix
    ./sops.nix
    ./system.nix
    ./users.nix
    inputs.lix-module.nixosModules.default
  ];
}
