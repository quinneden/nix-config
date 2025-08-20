{
  description = "Nix-darwin configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # lix.url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
    # lix.flake = false;

    # lix-module.url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
    lix-module.url = "git+https://git.lix.systems/lix-project/nixos-module?ref=release-2.93";
    lix-module.inputs.nixpkgs.follows = "nixpkgs";
    # lix-module.inputs.lix.follows = "lix";

    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    secrets.url = "git+ssh://git@github.com/quinneden/secrets";
    secrets.inputs = { };

    shellpers.url = "github:quinneden/shellpers";
    shellpers.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    virby.url = "github:quinneden/virby-nix-darwin";
    # virby.url = "path:/Users/William.Edenfield/src/personal/virby-nix-darwin";
    # virby.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, self, ... }@inputs:

    let
      inherit (nixpkgs) lib;

      system = "aarch64-darwin";

      mkCfg =
        host:
        inputs.nix-darwin.lib.darwinSystem {
          inherit system;

          specialArgs = { inherit inputs self; };

          modules = [
            ./modules/core
            (lib.path.append ./hosts host)
          ];
        };
    in

    {
      darwinConfigurations = lib.genAttrs (lib.attrNames (builtins.readDir ./hosts)) (host: mkCfg host);

      overlays.default =
        final: prev:
        (prev.lib.packagesFromDirectoryRecursive {
          callPackage = prev.lib.callPackageWith final;
          directory = ./pkgs;
        });
    };
}
