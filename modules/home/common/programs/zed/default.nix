{ pkgs, ... }:
let
  pythonEnv = pkgs.python3.withPackages (
    ps: with ps; [
      colorama
      ipykernel
      ipython
      jedi
      pip
      pycodestyle
      pyflakes
      pytest
      python-lsp-ruff
      python-lsp-server
      pyyaml
      requests
      rope
      ruff
    ]
  );
in
{
  imports = [ ./module.nix ];

  programs.zed-editor = {
    enable = pkgs.stdenv.isLinux;
    package = pkgs.zed-editor;

    extraPackages = with pkgs; [
      markdown-oxide
      marksman
      nixd
      nixfmt-rfc-style
      pythonEnv
      superhtml
      vscode-langservers-extracted
    ];

    extraThemes = [
      ./themes/AyuQ.json
      ./themes/MonolithHighlighted.json
    ];
  };
}
