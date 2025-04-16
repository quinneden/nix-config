{ lib, ... }:
{
  imports = (lib.custom.scanPaths ./.) ++ [ ../common ];
}
