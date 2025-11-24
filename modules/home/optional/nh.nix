{ user, ... }:

{
  programs.nh = {
    enable = true;
    darwinFlake = "/Users/${user}/.dotfiles";
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep-since 7d";
    };
  };
}
