{
  config,
  inputs,
  lib,
  self,
  ...
}:
{
  imports = lib.custom.scanPaths ./.;

  # home-manager = {
  #   backupFileExtension = "hm-backup";
  #   useGlobalPkgs = true;
  #   useUserPackages = true;
  #   extraSpecialArgs = { inherit inputs; };
  #   users.quinn = import ../../home;
  # };

  nix = {
    enable = true;
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
        "nix-command"
        "flakes"
      ];
      extra-substituters = [
        "https://quinneden.cachix.org"
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "quinneden.cachix.org-1:1iSAVU2R8SYzxTv3Qq8j6ssSPf0Hz+26gfgXkvlcbuA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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
