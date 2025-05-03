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
  programs.zed-editor = rec {
    enable = true;
    package = inputs.zed.packages.${pkgs.system}.default;

    extensions = [
      "basher"
      "env"
      "git-firefly"
      "html"
      "ini"
      "just"
      "make"
      "markdown-oxide"
      "marksman"
      "nix"
      "pylsp"
      "ruby"
      "ruff"
      "scss"
      "symbols"
      "toml"
    ];

    extraPackages = with pkgs; [
      github-mcp-server
      markdown-oxide
      marksman
      nixd
      nixfmt-rfc-style
      yaml-language-server
      package-version-server
      pythonEnv
      ruby
      ruff
      superhtml
      tailwindcss-language-server
      vtsls
    ];

    themes =
      with lib;
      mergeAttrsList (
        forEach (attrNames (builtins.readDir ./themes)) (theme: {
          "${removeSuffix ".json" theme}" = (./themes + ("/" + theme));
        })
      );

    userKeymaps = import ./keymap.nix { inherit lib pkgs; };
    userSettings = import ./settings.nix {
      inherit
        package
        lib
        inputs
        pkgs
        ;
    };
  };

  # xdg.configFile."zed/settings.json".enable = pkgs.stdenv.isLinux;
}
