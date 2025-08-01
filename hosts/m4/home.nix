{ inputs, ... }:

{
  imports = [ inputs.home-manager.darwinModules.default ];

  home-manager = {
    backupFileExtension = "hm-bck";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };

    users.quinn = {
      imports = [ ../../modules/home ];
      programs.home-manager.enable = true;
      home.stateVersion = "25.11";
    };
  };
}
