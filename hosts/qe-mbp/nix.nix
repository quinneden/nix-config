{
  lib,
  inputs,
  self,
  ...
}:

let
  nixpkgsInputs = [
    "nixpkgs2305"
    "nixpkgs2405"
    "nixpkgs2511"
  ];
in

{
  nix = {
    registry = lib.genAttrs nixpkgsInputs (f: {
      flake = inputs.${f};
    });

    settings = {
      accept-flake-config = true;
      access-tokens = [ "github=@/Users/William.Edenfield/.local/github-token" ];
      always-allow-substitutes = true;
      trusted-users = [ "William.Edenfield" ];
      extra-nix-path = map (f: "${f}=${inputs.${f}}") nixpkgsInputs;
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ self.overlays.default ];
  };
}
