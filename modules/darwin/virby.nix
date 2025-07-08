{
  # config,
  inputs,
  # lib,
  ...
}:
{
  imports = [ inputs.virby.darwinModules.default ];

  # nix.linux-builder.enable = true;
  services.virby = {
    enable = true;

    cores = 8;
    memory = 8192;
    diskSize = "150GiB";

    debug = true;
    onDemand = {
      enable = true;
      ttl = 180;
    };

    # extraConfig = {
    #   imports = [ inputs.lix-module.nixosModules.default ];

    #   nix = {
    #     optimise.automatic = true;
    #     settings = {
    #       inherit (config.nix.settings) access-tokens;
    #       max-free = lib.mkForce null;
    #       mix-free = lib.mkForce null;
    #     };
    #   };
    # };
  };
}
