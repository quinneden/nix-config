{ inputs, ... }:

{
  imports = [ inputs.home-manager.darwinModules.default ];

  home-manager = {
    backupFileExtension = "hm-bck";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };

    users.quinn = {
      imports = [
        ../../modules/home/core
        ../../modules/home/optional/direnv.nix
        ../../modules/home/optional/eza.nix
        ../../modules/home/optional/fzf.nix
        ../../modules/home/optional/git.nix
        ../../modules/home/optional/micro
        ../../modules/home/optional/packages.nix
        ../../modules/home/optional/pyenv.nix
        ../../modules/home/optional/python.nix
        ../../modules/home/optional/sh.nix
        ../../modules/home/optional/ssh.nix
        ../../modules/home/optional/starship.nix
        ../../modules/home/optional/zoxide.nix
        inputs.mac-app-util.homeManagerModules.default
      ];

      programs.home-manager.enable = true;
      home.stateVersion = "25.11";
    };
  };
}
