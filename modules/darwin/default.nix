{
  inputs,
  lib,
  self,
  ...
}:
{
  imports = (lib.custom.scanPaths ./.) ++ [ ../common ];

  lix.enable = false;

  nix.nixPath = [ "nix-darwin=${inputs.nix-darwin}" ];
  nixpkgs.overlays = [ self.overlays.darwin ];
}
