{ inputs, ... }:

{
  imports = [
    ../../modules/optional/sops.nix
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
