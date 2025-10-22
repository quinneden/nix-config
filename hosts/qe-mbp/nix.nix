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
    enable = false;
    registry = lib.genAttrs nixpkgsInputs (f: {
      flake = inputs.${f};
    });

    settings = {
      access-tokens = [ "github=@/Users/William.Edenfield/.local/github-token" ];
      always-allow-substitutes = true;
      trusted-users = [ "William.Edenfield" ];
      extra-nix-path = map (f: "${f}=${inputs.${f}}") nixpkgsInputs;
    };
  };

  determinate-nix = {
    # registry = lib.genAttrs nixpkgsInputs (f: {
    #   flake = inputs.${f};
    # });

    settings = {
      access-tokens = [ "github=@/Users/William.Edenfield/.local/github-token" ];
      trusted-users = [ "William.Edenfield" ];
      # extra-nix-path = map (f: "${f}=${inputs.${f}}") nixpkgsInputs;
      warn-dirty = false;
      connect-timeout = 5;
      fallback = true;
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      self.overlays.default
      inputs.nh.overlays.default
    ];
  };
}
