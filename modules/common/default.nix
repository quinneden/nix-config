{
  config,
  inputs,
  lib,
  self,
  ...
}:
{
  imports = lib.custom.scanPaths ./.;

  nix = {
    enable = true;
    channel.enable = true;
    distributedBuilds = true;
    nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
      "home-manager=${inputs.home-manager}"
    ];
    optimise.automatic = true;

    settings = {
      accept-flake-config = true;
      access-tokens = [ "github=@${config.sops.secrets.github_token.path}" ];
      always-allow-substitutes = true;
      builders-use-substitutes = true;
      experimental-features = [
        "flakes"
        "nix-command"
      ];

      substituters = [
        # "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://quinneden.cachix.org"
      ];

      trusted-public-keys = [
        # "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "quinneden.cachix.org-1:1iSAVU2R8SYzxTv3Qq8j6ssSPf0Hz+26gfgXkvlcbuA="
      ];

      trusted-substituters = config.nix.settings.substituters;
      trusted-users = [ "quinn" ];
      warn-dirty = false;
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.shellpers.overlays.default
      inputs.nh.overlays.default
      self.overlays.default
    ];
  };
}
