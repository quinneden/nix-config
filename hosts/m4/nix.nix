{ inputs, self, ... }:

{
  lix.enable = false;

  nix = {
    daemonProcessType = "Adaptive";

    nixPath = [
      "home-manager=${inputs.home-manager}"
      "nix-darwin=${inputs.nix-darwin}"
    ];

    settings = {
      accept-flake-config = true;
      always-allow-substitutes = true;
      trusted-users = [ "quinn" ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ self.overlays.default ];
  };
}
