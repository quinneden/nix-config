{
  inputs,
  lib,
  ...
}:
{
  imports = (lib.custom.scanPaths ./.) ++ [
    ../common
    inputs.mac-app-util.homeManagerModules.default
  ];
}
