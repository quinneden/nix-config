{ inputs, lib, ... }:

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

      users.${user} = {
        imports = [
          ../../modules/home/core
          ../../modules/home/optional/direnv.nix
          ../../modules/home/optional/micro
          ../../modules/home/optional/neovim.nix
          ../../modules/home/optional/nh.nix
          ../../modules/home/optional/programs.nix
          # ../../modules/home/optional/rift.nix
          ../../modules/home/optional/sh.nix
          ../../modules/home/optional/starship.nix
          ../../modules/home/optional/zoxide.nix
          inputs.mac-app-util.homeManagerModules.default
        ];

        programs.home-manager.enable = true;
        home.stateVersion = lib.versions.majorMinor lib.version;
      };
    };
}
