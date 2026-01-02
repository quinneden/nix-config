{
  description = "Nix-darwin configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # determinate-nix.url = "github:determinatesystems/nix-src";
    direnv-instant.url = "github:mic92/direnv-instant";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs";

    nh.url = "github:nix-community/nh";
    nh.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nvix.url = "github:niksingh710/nvix";
    nvix.inputs.nixpkgs.follows = "nixpkgs";

    # rift.url = "path:/Users/qeden/src/rift.nix";
    # rift.inputs.nixpkgs.follows = "nixpkgs";

    # secrets.url = "git+ssh://git@github.com/quinneden/secrets";
    # secrets.inputs = { };

    shellpers.url = "github:quinneden/shellpers";
    shellpers.inputs.nixpkgs.follows = "nixpkgs";
    shellpers.inputs.nh.follows = "nh";

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
