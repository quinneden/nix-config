{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  pythonEnv = pkgs.python313.withPackages (
    ps: with ps; [
      colorama
      ipykernel
      ipython
      pip
      pycodestyle
      pyflakes
      pytest
      python-lsp-jsonrpc
      (python-lsp-ruff.override { inherit (pkgs) ruff; })
      python-lsp-server
      pyyaml
      requests
      rope
    ]
  );
in
{
  programs.zed-editor = {
    enable = pkgs.stdenv.isLinux;

    extensions = [
      "basher"
      "dockerfile"
      "env"
      "git-firefly"
      "html"
      "ini"
      "justfile"
      "lua"
      "make"
      "markdown-oxide"
      "marksman"
      "nix"
      "oh"
      "pylsp"
      "ruff"
      "scss"
      "superhtml"
      "swift"
      "symbols"
      "toml"
    ];

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
      yaml-language-server
      tailwindcss-language-server
      vtsls
      ruff

    ];

    themes =
      with lib;
      mergeAttrsList (
        forEach (attrNames (builtins.readDir ./themes)) (theme: {
          "${removeSuffix ".json" theme}" = (./themes + ("/" + theme));
        })
      );

    userKeymaps = import ./keymap.nix;
    userSettings = import ./settings.nix { inherit inputs; };
  };
}
