{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.hdrop
    inputs.icon-browser.packages.${pkgs.system}.default
    btop
    gh
    git
    glow
    ripgrep
    jq
    jq-lsp
    nodejs
    parted
  ];
}
