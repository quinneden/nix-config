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
      extra-experimental-features = [
        "flakes"
        "nix-command"
      ];
      warn-dirty = false;
    };
  };
}
