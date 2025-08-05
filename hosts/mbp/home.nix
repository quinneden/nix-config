{ inputs, ... }:

{
  imports = [ inputs.home-manager.darwinModules.default ];

  home-manager =
    let
      user = "William.Edenfield";
    in
    {
      backupFileExtension = "hm-bck";
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs user; };

      users."William.Edenfield" = {
        imports = [
          ../../modules/home/programs/micro
          ../../modules/home/programs/direnv.nix
          ../../modules/home/programs/eza.nix
          ../../modules/home/programs/sh.nix
          ../../modules/home/programs/starship.nix
          ../../modules/home/programs/zoxide.nix
          ../../modules/home/external
        ];
        programs.home-manager.enable = true;
        home.stateVersion = "25.11";
      };
    };
}
