{
  description = "NixOS and nix-darwin configs for my machines";
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # NixOS Apple Silicon
    nixos-apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Catppuccin theme
    catppuccin.url = "github:catppuccin/nix";

    # Nix Darwin (for MacOS machines)
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Lix
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets
    secrets = {
      url = "git+ssh://git@github.com/quinneden/secrets.git?ref=main&shallow=1";
      inputs = { };
    };

    # Sops-Nix
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Shell Scripts
    shellpers.url = "github:quinneden/shellpers";
  };

  outputs =
    {
      self,
      catppuccin,
      darwin,
      home-manager,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });

      # Define user configurations
      users = {
        quinn = {
          avatar = ./files/avatar/face;
          email = "quinn@qeden.dev";
          fullName = "Quinn Edenfield";
          gitKey = "";
          name = "quinn";
        };
      };

      # Function for NixOS system configuration
      mkNixosConfiguration =
        hostname: username:
        nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = {
            inherit
              inputs
              lib
              outputs
              hostname
              ;
            userConfig = users.${username};
            nixosModules = "${self}/modules/nixos";
          };
          modules = [ ./hosts/${hostname} ];
        };

      # Function for nix-darwin system configuration
      mkDarwinConfiguration =
        hostname: username:
        darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit
              inputs
              lib
              outputs
              hostname
              ;
            userConfig = users.${username};
          };
          modules = [
            ./hosts/${hostname}
            home-manager.darwinModules.home-manager
          ];
        };

      # Function for Home Manager configuration
      mkHomeConfiguration =
        system: username: hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = {
            inherit inputs lib outputs;
            userConfig = users.${username};
            nhModules = "${self}/modules/home-manager";
          };
          modules = [
            ./home/${username}/${hostname}
            catppuccin.homeModules.catppuccin
          ];
        };
    in
    {
      nixosConfigurations = {
        macmini-m1 = mkNixosConfiguration "macmini-m1" "quinn";
      };

      darwinConfigurations = {
        macmini-m4 = mkDarwinConfiguration "macmini-m4" "quinn";
      };

      homeConfigurations = {
        "quinn@macmini-m1" = mkHomeConfiguration "x86_64-linux" "quinn" "macmini-m1";
        "quinn@macmini-m4" = mkHomeConfiguration "aarch64-darwin" "quinn" "macmini-m4";
      };

      overlays = import ./overlays { inherit inputs; };
    };
}
