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
      (python-lsp-ruff.override { inherit (pkgs) ruff; })
      python-lsp-server
      pyyaml
      requests
      rope
    ]
  );
in
{
  imports = [ ./module.nix ];

  programs.zed-editor = {
    enable = pkgs.stdenv.isLinux;

    extraPackages = with pkgs; [
      github-mcp-server
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
