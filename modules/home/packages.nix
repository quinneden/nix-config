{ inputs, pkgs, ... }:

let
  pythonEnv = pkgs.python313.withPackages (
    ps: with ps; [
      pycodestyle
      pyflakes
      python-lsp-jsonrpc
      (python-lsp-ruff.override { inherit (pkgs) ruff; })
      python-lsp-server
      requests
      rope
    ]
  );
in

{
  home.packages = with pkgs; [
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
    pythonEnv
    qemu
    vesktop
    zoxide
  ];
}
