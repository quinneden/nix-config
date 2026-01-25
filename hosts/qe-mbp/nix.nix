{ inputs, self, ... }:

{
  imports = [ inputs.determinate.darwinModules.default ];

  determinateNix = {
    enable = true;
    determinateNixd.builder.state = "disabled";
    distributedBuilds = true;
    customSettings = {
      accept-flake-config = true;
      access-tokens = [ "github=@/Users/William.Edenfield/.local/github-token" ];
      connect-timeout = 5;
      extra-experimental-features = [
        "build-time-fetch-tree"
        "external-builders"
        "parallel-eval"
      ];
      fallback = true;
      trusted-users = [ "@admin" ];
      warn-dirty = false;
    };
  };

  nix.enable = false;

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      self.overlays.default
      inputs.nh.overlays.default
    ];
  };
}
