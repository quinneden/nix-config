{ inputs, ... }:

{
  imports = [ inputs.virby.darwinModules.default ];

  # nix.settings = {
  #   extra-substituters = [ "https://virby-nix-darwin.cachix.org" ];
  #   extra-trusted-public-keys = [
  #     "virby-nix-darwin.cachix.org-1:z9GiEZeBU5bEeoDQjyfHPMGPBaIQJOOvYOOjGMKIlLo="
  #   ];
  # };

  services.virby = {
    enable = true;
    cores = 8;
    debug = true;
    memory = 16384;
    onDemand.enable = true;
    rosetta = true;
  };
}
