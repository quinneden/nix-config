{ self, ... }:

{
  nix.enable = false;
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ self.overlays.default ];
  };
}
