{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    inputs.shellpers.packages.${pkgs.system}.metapackage
    bat
    cachix
    fd
    file
    gawk
    gnutar
    gptfdisk
    nil
    nix-prefetch-git
    nix-prefetch-github
    nixd
    nixfmt-rfc-style
    qemu
  ];
}
