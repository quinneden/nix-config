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
          ../../modules/home/core
          ../../modules/home/optional/direnv.nix
          ../../modules/home/optional/micro
          ../../modules/home/optional/neovim.nix
          ../../modules/home/optional/programs.nix
          ../../modules/home/optional/rift.nix
          ../../modules/home/optional/sh.nix
          ../../modules/home/optional/starship.nix
          ../../modules/home/optional/zoxide.nix
        ];

        programs.home-manager.enable = true;
        home.stateVersion = "25.11";
      };
    };
}
