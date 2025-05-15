{ config, inputs, ... }:
{
  imports = [ inputs.nix-rosetta-builder.darwinModules.default ];

  nix-rosetta-builder = {
    enable = true;

    cores = 8;
    diskSize = "150GiB";
    memory = "8GiB";
    onDemand = true;
    withRosetta = false;

    potentiallyInsecureExtraNixosModule = {
      imports = [ inputs.lix-module.nixosModules.default ];

      nix = {
        optimise.automatic = true;
        settings = { inherit (config.nix.settings) access-tokens; };
      };
    };
  };
}
