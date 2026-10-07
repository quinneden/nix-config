{ den, inputs, ... }:

{
  den.aspects.core = {
    includes = [ (den.batteries.user-shell "zsh") ];

    darwin = {
      home-manager = {
        backupFileExtension = "hm-bck";
        useGlobalPkgs = true;
        useUserPackages = true;
      };

      nix = {
        distributedBuilds = true;
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

        settings = {
          accept-flake-config = true;
          access-tokens = [ "github=@/Users/qeden/.local/github-token" ];
          extra-experimental-features = [
            "ca-derivations"
            "dynamic-derivations"
            "flakes"
            "nix-command"
          ];

          extra-system-features = [ "builder-rpc-v0" ];
          trusted-users = [ "qeden" ];
          warn-dirty = false;
        };
      };
    };

    nixos = {
      home-manager = {
        backupFileExtension = "hm-bck";
        useGlobalPkgs = true;
        useUserPackages = true;
      };

      nix = {
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

        settings = {
          accept-flake-config = true;
          access-tokens = [ "github=@/home/qeden/.local/github-token" ];
          always-allow-substitutes = true;
          extra-experimental-features = [
            "flakes"
            "nix-command"
          ];

          trusted-users = [ "qeden" ];
          warn-dirty = false;
        };
      };
    };
  };
}
