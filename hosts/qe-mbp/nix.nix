{ inputs, self, ... }:

{
  nix = {
    enable = false;

    nixPath = [
      "home-manager=${inputs.home-manager}"
      "nix-darwin=${inputs.nix-darwin}"
    ];

    settings = {
      accept-flake-config = true;
      always-allow-substitutes = true;
      trusted-users = [ "William.Edenfield" ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ self.overlays.default ];
  };
}
