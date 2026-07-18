{ inputs, ... }:

{
  den.aspects.core = {
    darwin = { config, ... }: {
      imports = [ inputs.determinate.darwinModules.default ];

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

          trusted-users = [ "qeden" ];
          warn-dirty = false;
        };
      };

      nix.enable = !config.determinateNix.enable;
    };

    nixos = {
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
