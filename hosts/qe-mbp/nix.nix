{ inputs, self, ... }:

{
  imports = [ inputs.determinate.darwinModules.default ];

  determinateNix = {
    enable = true;
    nixosVmBasedLinuxBuilder.enable = true;
    customSettings = {
      accept-flake-config = true;
      access-tokens = [ "github=@/Users/William.Edenfield/.local/github-token" ];
      connect-timeout = 5;
      extra-experimental-features = [
        "parallel-eval"
        "build-time-fetch-tree"
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
