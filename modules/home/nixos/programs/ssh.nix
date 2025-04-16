{
  programs.ssh = {
    addKeysToAgent = "yes";
    matchBlocks = {
      "*".setEnv.TERM = "xterm-256color";
      "macmini-m4" = {
        hostname = "10.0.0.53";
        user = "quinn";
      };
    };
  };
}
