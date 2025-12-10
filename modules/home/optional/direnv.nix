{ inputs, ... }:

{
  imports = [ inputs.direnv-instant.homeModules.default ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.direnv-instant = {
    enable = true;
    settings = {
      debug_log = "/tmp/direnv-instant.log";
    };
  };
}
