{ inputs, ... }:

{
  imports = [
    ../../modules/optional/virby.nix
    ./brew.nix
    ./home.nix
    ./nix.nix
    ./system.nix
    ./users.nix
    inputs.mac-app-util.darwinModules.default
  ];
}
