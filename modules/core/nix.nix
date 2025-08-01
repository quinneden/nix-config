{ config, inputs, ... }:

{
  nix = {
    distributedBuilds = true;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    optimise.automatic = true;

    settings = {
      access-tokens = [ "github=@${config.sops.secrets.github_token.path}" ];
      builders-use-substitutes = true;
      experimental-features = "flakes nix-command";
      warn-dirty = false;
    };
  };
}
