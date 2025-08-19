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
    optimise.automatic = true;

    settings = {
      builders-use-substitutes = true;
      experimental-features = "flakes nix-command";
      warn-dirty = false;
    };
  };
}
