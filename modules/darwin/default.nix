{
  inputs,
  lib,
  self,
  ...
}:
{
  imports = (lib.custom.scanPaths ./.) ++ [ ../common ];

  nix.nixPath = [ "nix-darwin=${inputs.nix-darwin}" ];
  nixpkgs.overlays = [ self.overlays.darwin ];
}
