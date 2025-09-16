{ self, ... }:

{
  nix.settings = {
    accept-flake-config = true;
    access-tokens = [ "github=@/Users/William.Edenfield/.local/github-token" ];
    always-allow-substitutes = true;
    trusted-users = [ "William.Edenfield" ];
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ self.overlays.default ];
  };
}
