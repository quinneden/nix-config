{ pkgs, ... }:
let
  homeDir = "${if pkgs.stdenv.isDarwin then "/Users" else "/home"}/quinn";
in
{
  programs.nh = {
    enable = true;
    flake = "${homeDir}/.dotfiles";
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d";
  };
}
