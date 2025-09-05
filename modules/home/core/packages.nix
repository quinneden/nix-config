{ inputs, pkgs, ... }:

let
  nixfmt-tree =
    (pkgs.treefmt.withConfig {
      runtimeInputs = [ pkgs.nixfmt-rfc-style ];
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
in

{
  home.packages = with pkgs; [
    inputs.shellpers.packages.${pkgs.system}.metapackage
    bat
    cachix
    fd
    file
    gawk
    gnutar
    gptfdisk
    nil
    nix-prefetch-git
    nix-prefetch-github
    nixd
    nixfmt
    nixfmt-tree
    qemu
  ];
}
