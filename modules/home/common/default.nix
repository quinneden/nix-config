{ inputs, lib, ... }:
{
  imports = (lib.custom.scanPaths ./.) ++ [
    ../external
    inputs.sops-nix.homeManagerModules.sops
  ];
  programs.home-manager.enable = true;
  home.stateVersion = "25.05";
}
