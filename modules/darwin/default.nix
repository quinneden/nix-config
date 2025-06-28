{ lib, self, ... }:
{
  imports = (lib.custom.scanPaths ./.) ++ [ ../common ];

  nixpkgs.overlays = [ self.overlays.darwin ];
}
