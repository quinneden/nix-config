{
  homebrew = {
    enable = true;

    global = {
      autoUpdate = true;
      brewfile = true;
    };

    onActivation = {
      upgrade = true;
      cleanup = "zap";
      extraFlags = [ "--quiet" ];
    };
  };
}
