{ darwinConfig, ... }:

{
  programs.ssh = {
    enable = true;

    addKeysToAgent = "yes";
    includes = [ "config.d/*.conf" ];

    matchBlocks = {
      "macmini-m1".hostname = "10.0.0.244";

      "oc-runner" = {
        hostname = "100.88.22.94"; # 129.146.66.178
        user = "quinn";
        identityFile = darwinConfig.sops.secrets.ssh_ed25519_oc-runner.path;
      };

      "picache" = {
        hostname = "10.0.0.101";
        user = "qeden";
        identityFile = darwinConfig.sops.secrets.ssh_ed25519_picache.path;
      };
    };
  };
}
