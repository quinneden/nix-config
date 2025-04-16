{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    inputs.shellpers.packages.${pkgs.system}.metapackage
    bat
    cachix
    direnv
    eza
    gawk
    gnutar
    fzf
    neovim
    nix-prefetch-git
    nix-prefetch-github
    nixfmt-rfc-style
    qemu
    zoxide
  ];
}
