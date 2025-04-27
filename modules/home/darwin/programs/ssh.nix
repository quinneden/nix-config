{
  programs.ssh = {
    addKeysToAgent = "yes";
    matchBlocks = {
      "macos-macmini-m1".hostname = "10.0.0.235";
      "nixos-macmini-m1".hostname = "10.0.0.245";
    };
  };
}
