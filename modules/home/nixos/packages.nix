{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.hdrop
    inputs.icon-browser.packages.${pkgs.system}.default
    btop
    gh
    git
    glow
    rclone
    ripgrep
    jq
    jq-lsp
    muvm
    nodejs
    parted
  ];
}
