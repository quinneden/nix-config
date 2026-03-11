{
  config,
  inputs,
  self,
  ...
}:

{
  imports = [ inputs.determinate.darwinModules.default ];

  determinateNix = {
    enable = true;
    distributedBuilds = true;
    determinateNixd = {
      builder.cpuCount = 4;
      builder.memoryBytes = 16 * 1024 * 1024;
      builder.state = "disabled";
    };
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

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      self.overlays.default
      inputs.nh.overlays.default
      inputs.nil.overlays.default
      inputs.nixd.overlays.default
    ];
  };
}
