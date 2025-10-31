{ config, ... }:

{
  programs.nh = {
    enable = true;
    flake = "${config.users.users.quinn.home}/.dotfiles";
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d";
  };

  environment.sessionVariables.NH_DARWIN_FLAKE = config.programs.nh.flake;
}
