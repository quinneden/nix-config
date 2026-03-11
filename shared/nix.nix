{
  config,
  inputs,
  lib,
  ...
}:

{
  nix = lib.mkIf config.nix.enable {
    distributedBuilds = true;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    settings = {
      builders-use-substitutes = true;
      extra-experimental-features = [
        "flakes"
        "nix-command"
      ];
      warn-dirty = false;
    };
  };
}
