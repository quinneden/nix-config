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
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
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
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://quinneden.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "quinneden.cachix.org-1:1iSAVU2R8SYzxTv3Qq8j6ssSPf0Hz+26gfgXkvlcbuA="
      ];
      trusted-users = [
        "quinn"
        "root"
      ];
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
