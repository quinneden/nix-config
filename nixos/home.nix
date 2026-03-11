{
  inputs,
  self,
  config,
  pkgs,
  ...
}:

{
  home-manager = {
    backupFileExtension = "hm.bck";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs self; };
    users.qeden = {
      imports = [
        ../home/nixos
        ../home/shared
      ];

      manual.manpages.enable = false;
      news.display = "show";

      home = {
        username = "qeden";
        homeDirectory = "/home/qeden";
        sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
        sessionVariables = {
          BAT_THEME = "base16";
          PAGER = "${pkgs.bat}/bin/bat --style=plain";
        };
      };

      xdg.configFile."gtk-4.0/bookmarks".text =
        let
          home = config.home.homeDirectory;
        in
        ''
          file://${home}/Desktop
          file://${home}/Documents
          file://${home}/Downloads
          file://${home}/Pictures
          file://${home}/src Src
          file://${home}/Videos
          file://${home}/workdir Workdir
        '';

      programs.home-manager.enable = true;
      home.stateVersion = "26.05";
    };
  };
}
