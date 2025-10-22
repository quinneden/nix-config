{ inputs, pkgs, ... }:

let
  neovim = inputs.nvix.packages.${pkgs.system}.default.extend {

  };
in

{
  home.packages = [ neovim ];
}
