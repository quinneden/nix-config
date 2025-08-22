{ self, ... }:

{
  nix = {
    settings = {
      access-tokens = [ "github=@/Users/William.Edenfield/.local/github-token" ];
      accept-flake-config = true;
      always-allow-substitutes = true;
      trusted-users = [ "William.Edenfield" ];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ self.overlays.default ];
  };
}
