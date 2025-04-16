{ lib, ... }:
{
  imports = (lib.custom.scanPathsExcept "colors.nix" ./.) ++ [ ../common ];
}
