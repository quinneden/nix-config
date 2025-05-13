{
  config,
  inputs,
  pkgs,
  ...
}:
let
  secretsPath = "${inputs.secrets}/sops";
  homeDir = "${if pkgs.stdenv.isDarwin then "/Users" else "/home"}/quinn";
in
{
  sops = {
    defaultSopsFile = "${secretsPath}/default.yaml";
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      "github_token" = { };
      "passwords/quinn" = { };
      "passwords/root" = { };
      "keys/oc-runner" = {
        mode = "0600";
        owner = config.users.users.quinn.name;
        path = "${homeDir}/.ssh/keys/oc-runner";
        sopsFile = "${secretsPath}/keys/ssh_ed25519_oc-runner";
      };
      "keys/picache" = {
        mode = "0600";
        owner = config.users.users.quinn.name;
        path = "${homeDir}/.ssh/keys/picache";
        sopsFile = "${secretsPath}/keys/ssh_ed25519_picache";
      };
    };
  };
}
