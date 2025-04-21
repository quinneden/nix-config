{ inputs, pkgs, ... }:
{
  fonts.packages = [
    inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd
  ];
}
