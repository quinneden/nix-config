{ config, pkgs, ... }:

{
  programs.micro = {
    enable = true;

    extraSyntax = {
      nix = ./syntax/nix.yaml;
    };

    keybindings = {
      "Ctrl-j" = "lua:joinLines.joinLines";
    };

    plugins = [
      "joinLines"
      "quoter"
      "autofmt"
    ];

    settings = {
      autoclose = true;
      autosu = true;
      colorscheme = "simple";
      comment = true;
      diff = true;
      ftoptions = true;
      initlua = true;
      linter = true;
      literate = true;
      pluginrepos = [ "https://github.com/sparques/micro-quoter/raw/refs/heads/master/repo.json" ];
      parsecursor = true;
      reload = "auto";
      rmtrailingws = true;
      saveundo = true;
      tabhighlight = true;
      tabsize = 2;
      tabstospaces = true;
    };
  };

  home.file."micro-colors" = {
    recursive = true;
    target = config.xdg.configHome + "/micro/colorschemes";
    source = pkgs.micro-colors;
  };

  home.file."micro-autofmt" = {
    recursive = true;
    target = config.xdg.configHome + "/micro/plug/autofmt";
    source = pkgs.micro-autofmt;
  };
}
