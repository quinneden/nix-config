{
  programs.ssh = {
    addKeysToAgent = "yes";
    matchBlocks = {
      "macmini-m1".hostname = "10.0.0.235";
      "nixos-macmini".hostname = "10.0.0.245";
    };
  };
}
