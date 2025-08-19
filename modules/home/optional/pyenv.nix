{ config, ... }:

{
  programs.pyenv = {
    enable = true;
    rootDirectory = config.xdg.dataHome + "/pyenv";
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
