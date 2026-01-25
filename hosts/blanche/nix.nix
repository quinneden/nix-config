{ inputs, self, ... }:

{
  imports = [ inputs.determinate.darwinModules.default ];

  nix.enable = false;

  determinateNix = {
    enable = true;
    distributedBuilds = true;
    determinateNixd = {
      builder.cpuCount = 8;
      builder.memoryBytes = 16 * 1024 * 1024;
      builder.state = "enabled";
    };
    customSettings = {
      accept-flake-config = true;
      access-tokens = [ "github=@/Users/qeden/.local/github-token" ];
      always-allow-substitutes = true;
      extra-experimental-features = [
        "external-builders"
        "parallel-eval"
      ];
      trusted-users = [ "qeden" ];
      warn-dirty = false;
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      self.overlays.default
      inputs.nh.overlays.default
    ];
  };
}
