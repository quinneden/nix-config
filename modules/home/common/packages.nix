{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    # inputs.acmsg.packages.${pkgs.system}.acmsg
    inputs.shellpers.packages.${pkgs.system}.metapackage
    bat
    cachix
    direnv
    eza
    fd
    file
    fzf
    gawk
    gnutar
    gptfdisk
    nil
    nix-prefetch-git
    nix-prefetch-github
    nixd
    nixfmt-rfc-style
    qemu
    vesktop
    zoxide
  ];
}
