{ inputs, pkgs, ... }:

let
  nixfmt-tree =
    (pkgs.treefmt.withConfig {
      runtimeInputs = [ pkgs.nixfmt ];
      settings = {
        on-unmatched = "info";
        formatter.nixfmt = {
          command = "nixfmt";
          options = [ "--strict" ];
          includes = [ "*.nix" ];
        };
      };
    }).overrideAttrs
      (old: {
        buildCommand = (
          old.buildCommand
          + ''
            mv $out/bin/treefmt $out/bin/nixfmt-tree
          ''
        );
      });

  bash-language-server = pkgs.bash-language-server.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (pkgs.writeText "bashls-tldr.patch" ''
        diff --git a/src/bash.rs b/src/bash.rs
        index d9cdd6b..d8fc8f5 100644
        --- a/src/bash.rs
        +++ b/src/bash.rs
        @@ -1,8 +1,8 @@
         use std::{env, fs};
         use zed_extension_api::{self as zed, Result};

        -const SERVER_PATH: &str = "node_modules/bash-language-server/out/cli.js";
        -const PACKAGE_NAME: &str = "bash-language-server";
        +const SERVER_PATH: &str = "node_modules/neo-bash-ls/out/cli.js";
        +const PACKAGE_NAME: &str = "neo-bash-ls";

         struct BashExtension {
             did_find_server: bool,
      '')
    ];
  });
in

{
  home.packages = with pkgs; [
    inputs.shellpers.packages.${pkgs.system}.metapackage
    bash-language-server
    bat
    cachix
    fd
    file
    gawk
    gnutar
    gptfdisk
    nh
    nil
    nix-prefetch-git
    nix-prefetch-github
    nixd
    nixfmt
    nixfmt-tree
    qemu
  ];
}
