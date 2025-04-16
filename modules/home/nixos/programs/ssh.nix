{
  programs.ssh = {
    addKeysToAgent = "yes";
    matchBlocks = {
      "macmini-m4" = {
        hostname = "10.0.0.53";
        user = "quinn";
      };
    };
  };
}
