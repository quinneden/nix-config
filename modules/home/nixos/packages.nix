{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    gh
    git
    glow
    inputs.hyprland-contrib.packages.${pkgs.system}.hdrop
    inputs.icon-browser.packages.${pkgs.system}.default
    jq
    jq-lsp
    muvm
    nodejs
    parted
    rclone
    ripgrep
  ];
}
