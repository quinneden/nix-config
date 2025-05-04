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
        "nix-command"
        "flakes"
      ];
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://quinneden.cachix.org"
        "https://zed-industries.cachix.org"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "quinneden.cachix.org-1:1iSAVU2R8SYzxTv3Qq8j6ssSPf0Hz+26gfgXkvlcbuA="
        "zed-industries.cachix.org-1:QW3RoXK0Lm4ycmU5/3bmYRd3MLf4RbTGPqRulGlX5W0="
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
      inputs.zed.overlays.default
      self.overlays.default
    ];
  };
}
