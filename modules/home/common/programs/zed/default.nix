{
  config,
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
  imports = [ inputs.zed-extensions.homeManagerModules.default ];

  programs = {
    zed-editor = rec {
      enable = true;
      package =
        if pkgs.stdenv.isDarwin then
          (
            (pkgs.writeShellScriptBin "zeditor" ''
              if [[ -e '/Applications/Zed.app' ]]; then
                exec /Applications/Zed.app/Contents/MacOS/cli "$@"
              elif [[ -e '/Applications/Zed Preview.app' ]]; then
                exec /Applications/'Zed Preview.app'/Contents/MacOS/cli "$@"
              else
                echo 'error: no zed application was found' >&2
                exit 1
              fi
            '')
            // {
              version = "homebrew";
            }
          )
        else
          pkgs.zed-editor;

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
          config
          inputs
          lib
          pkgs
          package
          ;
      };
    };

    zed-editor-extensions = {
      enable = pkgs.stdenv.isLinux;
      packages = with pkgs.zed-extensions; [
        basher
        env
        git-firefly
        html
        ini
        just
        make
        markdown-oxide
        marksman
        mcp-server-context7
        mcp-server-github
        nix
        pylsp
        ruff
        scss
        superhtml
        symbols
        toml
      ];
    };
  };

  xdg.configFile."zed/settings.json".enable = pkgs.stdenv.isLinux;
}
