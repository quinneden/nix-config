{ lib, self, ... }:
{
  imports = lib.custom.scanPaths ./.;

  nixpkgs.overlays = [
    self.overlays.darwin
  ];
}
