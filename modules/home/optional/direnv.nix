{ inputs, ... }:

{
  imports = [ inputs.direnv-instant.homeModules.default ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = false;
    enableBashIntegration = false;
  };

  programs.direnv-instant.enable = true;
}
