{
  inputs,
  pkgs,
  self,
  ...
}:

{
  nix = {
    enable = true;
    package = pkgs.nixVersions.latest;
    settings = {
      access-tokens = [ "github=@/Users/qeden/.local/github-token" ];
      always-allow-substitutes = true;
      trusted-users = [ "qeden" ];
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
