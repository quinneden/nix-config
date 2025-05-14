{
  inputs,
  lib,
  self,
  ...
}:
{
  imports = (lib.custom.scanPaths ./.) ++ [ ../common ];

  nixpkgs.overlays = [
    inputs.zed-extensions.overlays.default
    self.overlays.linux
  ];
}
