{ inputs, pkgs, ... }:

{
  imports = [ inputs.direnv-instant.homeModules.default ];

  programs.direnv = {
    enable = true;
    package = pkgs.direnv.overrideAttrs { doCheck = false; }; # TODO: check if still necessary
    nix-direnv.enable = true;
  };

  programs.direnv-instant = {
    enable = true;
    settings = {
      debug_log = "/tmp/direnv-instant.log";
    };
  };
}
