{
  description = "NixOS(-Apple-Silicon) and Nix-darwin configurations.";

  outputs =
    {
      nix-darwin,
      nixpkgs,
      self,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
      specialArgs = { inherit inputs lib self; };
    in
    {
      darwinConfigurations = {
        macmini-m4 = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [ ./hosts/m4 ];
          inherit specialArgs;
        };
      };

      nixosConfigurations = {
        macmini-m1 = lib.nixosSystem {
          system = "aarch64-linux";
          modules = [ ./hosts/m1 ];
          inherit specialArgs;
        };
      };

      overlays = import ./overlays;

      formatter = lib.genAttrs [ "aarch64-darwin" "aarch64-linux" ] (
        system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style
      );
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-apple-silicon = {
      url = "github:oliverbestmann/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+ssh://git@github.com/quinneden/secrets?ref=main&shallow=1";
      inputs = { };
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    marble-shell = {
      url = "git+ssh://git@github.com/quinneden/marble-shell?ref=aarch64-linux/gtk4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    icon-browser = {
      url = "github:quinneden/icon-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lf-icons = {
      url = "github:gokcehan/lf";
      flake = false;
    };

    acmsg.url = "github:quinneden/acmsg";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    mac-app-util.url = "github:hraban/mac-app-util";
    nh.url = "github:viperml/nh";
    nix-rosetta-builder.url = "github:quinneden/nix-rosetta-builder?ref=opinionated";
    shellpers.url = "github:quinneden/shellpers";
    zen-browser.url = "github:youwen5/zen-browser-flake";
  };
}
