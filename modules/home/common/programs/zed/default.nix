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
      python-lsp-server
      (python-lsp-ruff.override { inherit (pkgs) ruff; })
      pyyaml
      requests
      rope
    ]
  );
in
{
  programs.zed-editor = {
    enable = pkgs.stdenv.isLinux;

    extraPackages = with pkgs; [
      github-mcp-server
      markdown-oxide
      marksman
      nixd
      nixfmt-rfc-style
      package-version-server
      pythonEnv
      superhtml
      vscode-langservers-extracted
    ];

    themes = {
      AyuQ = ./themes/AyuQ.json;
      MonolithHighlighted = ./themes/MonolithHighlighted.json;
    };
  };
}
