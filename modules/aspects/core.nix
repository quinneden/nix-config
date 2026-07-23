{ inputs, ... }:

{
  den.aspects.core = {
    darwin = { config, ... }: {
      imports = [ inputs.determinate.darwinModules.default ];

      home-manager = {
        backupFileExtension = "hm-bck";
        useGlobalPkgs = true;
        useUserPackages = true;
      };

      determinateNix = {
        enable = true;
        distributedBuilds = true;
        determinateNixd.builder.state = "disabled";

        customSettings = {
          accept-flake-config = true;
          access-tokens = [ "github=@/Users/qeden/.local/github-token" ];
          extra-experimental-features = [
            "build-time-fetch-tree"
            "external-builders"
            "parallel-eval"
            "wasm-builtin"
          ];

          nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
          trusted-users = [ "qeden" ];
          warn-dirty = false;
        };
      };

      nix.enable = !config.determinateNix.enable;
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
