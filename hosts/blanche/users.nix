{ pkgs, ... }:

{
  users.users."qeden" = {
    description = "Quinn Edenfield";
    home = "/Users/qeden";
    shell = pkgs.zsh;
  };
}
