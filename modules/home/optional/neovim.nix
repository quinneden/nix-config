{ inputs, pkgs, ... }:

let
  neovim = inputs.nvix.packages.${pkgs.stdenv.hostPlatform.system}.default.extend {

  };
in

{
  home.packages = [ neovim ];
}
