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
        hostname = "129.146.66.178";
        user = "root";
        identityFile = systemConfig.sops.secrets."keys/oc-runner".path;
      };

      "picache" = {
        hostname = "10.0.0.101";
        user = "qeden";
      };
    };
  };
}
