{
  programs = {
    pyenv.enable = true;
    fzf.enable = true;
    eza.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  };
}
