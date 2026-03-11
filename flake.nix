{
  description = "NixOS and Nix-darwin configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    determinate.url = "github:determinatesystems/determinate";
    direnv-instant.url = "github:mic92/direnv-instant";

    dms.url = "github:AvengeMedia/DankMaterialShell/stable";
    dms.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    lf.url = "github:gokcehan/lf";
    lf.flake = false;

    mac-app-util.url = "github:hraban/mac-app-util";

    nh.url = "github:nix-community/nh";
    nh.inputs.nixpkgs.follows = "nixpkgs";

    nil.url = "github:oxalica/nil";

    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixd.url = "github:nix-community/nixd";

    nixos-apple-silicon.url = "github:nix-community/nixos-apple-silicon";
    nixos-apple-silicon.inputs.nixpkgs.follows = "nixpkgs";

    # secrets.url = "git+ssh://git@github.com/quinneden/secrets";
    # secrets.inputs = { };

    shellpers.url = "github:quinneden/shellpers";
    shellpers.inputs.nixpkgs.follows = "nixpkgs";
    shellpers.inputs.nh.follows = "nh";

    # sops-nix.url = "github:mic92/sops-nix";
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # virby.url = "github:quinneden/virby-nix-darwin";
    virby.url = "path:/Users/qeden/src/virby-nix-darwin/worktrees/feat/krunkit";
    # virby.url = "path:/Users/qeden/src/virby-nix-darwin/worktrees/main";
    # virby.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, self, ... }@inputs:
    {
      darwinConfigurations.blanche = inputs.nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs self; };
        modules = [ ./darwin ];
      };

      nixosConfigurations.blanche = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs self; };
        modules = [ ./nixos ];
      };

      overlays.default =
        final: prev:
        (prev.lib.packagesFromDirectoryRecursive {
          callPackage = prev.lib.callPackageWith final;
          directory = ./pkgs;
        });
    };
}
