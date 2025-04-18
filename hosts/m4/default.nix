{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = (lib.custom.scanPaths ./.) ++ [
    inputs.home-manager.darwinModules.default
    inputs.lix-module.nixosModules.default
    inputs.mac-app-util.darwinModules.default
    inputs.sops-nix.darwinModules.default
    ../../modules/darwin
  ];

  users.users.quinn = {
    description = "Quinn Edenfield";
    home = "/Users/quinn";
    shell = pkgs.zsh;
  };

  nix.daemonProcessType = "adaptive";
  security.pam.services.sudo_local.touchIdAuth = true;
}
