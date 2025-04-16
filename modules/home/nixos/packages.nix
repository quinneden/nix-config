{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    inputs.icon-browser.packages.${pkgs.system}.default
    btop
    gh
    git
    ripgrep
  ];
}
