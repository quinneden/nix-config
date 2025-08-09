{ pkgs, ... }:

{
  users.users."William.Edenfield" = {
    description = "Quinn Edenfield";
    home = "/Users/William.Edenfield";
    shell = pkgs.zsh;
  };
}
