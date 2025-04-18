{
  inputs,
  lib,
  ...
}:
{
  imports = (lib.custom.scanPaths ./.) ++ (with inputs; [ mac-app-util.homeManagerModules.default ]);
}
