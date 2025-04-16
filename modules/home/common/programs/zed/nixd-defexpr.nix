let
  home-manager = builtins.getFlake "flake:home-manager";
  nix-darwin = builtins.getFlake "flake:nix-darwin";
  nixpkgs = builtins.getFlake "flake:nixpkgs";

  darwinSystem = nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    modules = [ { system.stateVersion = 6; } ];
  };

  homeConfig = home-manager.lib.homeManagerConfiguration rec {
    pkgs = import nixpkgs { system = builtins.currentSystem; };
    modules = [
      {
        home = {
          stateVersion = with pkgs.lib; versions.majorMinor version;
          username = "quinn";
          homeDirectory =
            if (builtins.currentSystem == "aarch64-darwin") then "/Users/quinn" else "/home/quinn";
        };
      }
    ];
  };

  nixosSystem = nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    modules = [ { system.stateVersion = with nixpkgs.lib; versions.majorMinor version; } ];
  };
in
{
  darwinOptions = darwinSystem.options;
  homeOptions = homeConfig.options;
  nixosOptions = nixosSystem.options;
}
