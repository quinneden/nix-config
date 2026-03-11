{
  programs.ssh = {
    enable = true;
    matchBlocks."*" = {
      addKeysToAgent = "yes";
    };
  };

  services.ssh-agent.enable = true;
}
