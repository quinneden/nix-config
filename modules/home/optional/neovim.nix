{ inputs, pkgs, ... }:

let
  neovim = inputs.nvix.packages.${pkgs.stdenv.hostPlatform.system}.core;
in

{
  home.packages = [ neovim ];
}
