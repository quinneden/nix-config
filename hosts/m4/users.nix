{ pkgs, ... }:

{
  users.users.quinn = {
    description = "Quinn Edenfield";
    home = "/Users/quinn";
    shell = pkgs.zsh;
  };
}
