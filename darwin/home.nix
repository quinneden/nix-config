{ inputs, ... }:

{
  imports = [ inputs.home-manager.darwinModules.default ];

  home-manager =
    let
      user = "qeden";
    in
    {
      backupFileExtension = "hm-bck";
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs user; };

      users."qeden" = {
        imports = [
          ../home/darwin
          ../home/shared
        ];

        programs.home-manager.enable = true;
        home.stateVersion = "25.11";
      };
    };
}
