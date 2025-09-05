{ self, ... }:

{
  nix.settings = {
    # accept-flake-config = true;
    access-tokens = [ "github=@/Users/William.Edenfield/.local/github-token" ];
    always-allow-substitutes = true;

    extra-substituters = [
      # "https://ceph-fre-job.int.n7k.io/nix-cache"
      "https://cache.lix.systems"
    ];

    extra-trusted-public-keys = [ "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o=" ];
    # extra-trusted-substituters = [ "https://ceph-fre-job.int.n7k.io/nix-cache" ];
    require-sigs = false;
    trusted-users = [ "William.Edenfield" ];
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ self.overlays.default ];
  };
}
