{
  config,
  inputs,
  self,
  ...
}:

{
  nix = {
    daemonProcessType = "Adaptive";

    nixPath = [
      "home-manager=${inputs.home-manager}"
      "nix-darwin=${inputs.nix-darwin}"
    ];

    settings = {
      access-tokens = [ "github=@${config.sops.secrets.github_token.path}" ];
      accept-flake-config = true;
      always-allow-substitutes = true;
      trusted-users = [ "quinn" ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ self.overlays.default ];
  };
}
