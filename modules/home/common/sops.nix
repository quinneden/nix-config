{ inputs, pkgs, ... }:
let
  secretsPath = "${inputs.secrets}/sops";
  homeDir = "${if pkgs.stdenv.isDarwin then "/Users" else "/home"}/quinn";
in
{
  sops = {
    defaultSopsFile = "${secretsPath}/default.yaml";
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "${homeDir}/.ssh/id_ed25519" ];
      keyFile = "${homeDir}/.config/sops/key.txt";
      generateKey = true;
    };

    secrets = {
      github_token = { };

      "plain/rclone.ini" = {
        format = "ini";
        sopsFile = "${secretsPath}/plain/rclone.ini";
        path = "${homeDir}/.config/rclone/rclone.conf";
      };
    };
  };
}
