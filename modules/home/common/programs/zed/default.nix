{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  pythonEnv = pkgs.python313.withPackages (
    ps: with ps; [
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
      uv
    ]
  );
in
{
  imports = [ inputs.zed-extensions.homeManagerModules.default ];

  programs = {
    zed-editor = {
      enable = pkgs.stdenv.isLinux;

      extraPackages = with pkgs; [
        github-mcp-server
        just-lsp
        marksman
        nixd
        nixfmt-rfc-style
        yaml-language-server
        package-version-server
        pythonEnv
        ruff
      ];

      themes =
        with lib;
        mergeAttrsList (
          forEach (attrNames (builtins.readDir ./themes)) (theme: {
            "${removeSuffix ".json" theme}" = ./themes + ("/" + theme);
          })
        );

      userKeymaps = import ./keymap.nix { inherit lib pkgs; };
      userSettings = import ./settings.nix { inherit inputs pkgs; };
    };

    zed-editor-extensions = {
      enable = pkgs.stdenv.isLinux;
      packages = with pkgs.zed-extensions; [
        basher
        mcp-server-byterover
        env
        git-firefly
        html
        ini
        just
        make
        marksman
        mcp-server-context7
        mcp-server-github
        nix
        pylsp
        ruff
        tombi
        toml
      ];
    };
  };
}
