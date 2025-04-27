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
        settings = { inherit (config.nix.settings) access-tokens; };
      };
    };
    memory = "8GiB";
    onDemand = true;
    withRosetta = false;
  };
}
