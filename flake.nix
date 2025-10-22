{
  description = "Nix-darwin configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixpkgs2305.url = "github:nixos/nixpkgs?rev=19cf008bb18e47b6e3b4e16e32a9a4bdd4b45f7e";
    nixpkgs2405.url = "github:nixos/nixpkgs?rev=c8257f4524ee5863ee3421508e8b9ed500decf48";
    nixpkgs2511.url = "github:nixos/nixpkgs?rev=a595dde4d0d31606e19dcec73db02279db59d201";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs";

    nh.url = "github:nix-community/nh";
    nh.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nvix.url = "github:niksingh710/nvix";
    nvix.inputs.nixpkgs.follows = "nixpkgs";

    secrets.url = "git+ssh://git@github.com/quinneden/secrets";
    secrets.inputs = { };

    shellpers.url = "github:quinneden/shellpers";
    shellpers.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    virby.url = "github:quinneden/virby-nix-darwin";
    virby.inputs.nixpkgs.follows = "nixpkgs";
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
