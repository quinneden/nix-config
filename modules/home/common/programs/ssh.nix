{
  darwinConfig,
  nixosConfig,
  pkgs,
  ...
}:
let
  systemConfig = if pkgs.stdenv.isDarwin then darwinConfig else nixosConfig;
in
{
  programs.ssh = {
    enable = true;
    includes = [ "config.d/*.conf" ];
    matchBlocks = {
      "oc-runner" = {
        hostname = "100.88.22.94"; # 129.146.66.178
        user = "quinn";
        identityFile = systemConfig.sops.secrets.ssh_ed25519_oc-runner.path;
      };

      "picache" = {
        hostname = "10.0.0.101";
        user = "qeden";
        identityFile = systemConfig.sops.secrets.ssh_ed25519_picache.path;
      };
    };
  };
}
