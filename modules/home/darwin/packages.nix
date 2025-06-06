{ pkgs, ... }:
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
  home.packages = [ pythonEnv ];
}
