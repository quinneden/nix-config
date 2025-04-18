{
  config,
  pkgs,
  ...
}:
{
  imports = [ ./module.nix ];

  programs.micro = {
    enable = true;

    extraSyntax = {
      nix = ./syntax/nix.yaml;
    };

    plugins = [
      "joinLines"
    ];

    settings = {
      autoclose = true;
      autosu = true;
      colorscheme = "cuddles";
      comment = true;
      diff = true;
      ftoptions = true;
      initlua = true;
      linter = true;
      literate = true;
      pluginrepos = [
        "https://github.com/sparques/micro-quoter/raw/refs/heads/master/repo.json"
        "https://github.com/AndCake/micro-plugin-lsp/raw/refs/heads/master/repo.json"
      ];
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
