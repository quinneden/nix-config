{ config, inputs, ... }:
{
  imports = [ inputs.nix-rosetta-builder.darwinModules.default ];

  nix-rosetta-builder = {
    enable = true;
    cores = 8;
    diskSize = "150GiB";
    extraConfig = {
      nix = {
        optimise.automatic = true;
        settings = {
          inherit (config.nix.settings)
            access-tokens
            extra-substituters
            extra-trusted-public-keys
            warn-dirty
            ;
        };
      };
    };
    memory = "8GiB";
    onDemand = true;
    withRosetta = false;
  };
}
