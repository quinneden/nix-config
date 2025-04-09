{
  config,
  inputs,
  pkgs,
  ...
}:
let
  secretsPath = toString inputs.secrets + "/sops";
  homeDirectory = if pkgs.stdenv.isDarwin then "/Users/quinn" else "/home/quinn";
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
      github_token = { };

      "passwords/quinn" = { };
      "passwords/root" = { };

      "private_keys/oc-runner" = {
        mode = "0600";
        owner = config.users.users.quinn.name;
        path = "${homeDirectory}/.ssh/keys/oc-runner";
      };
      "private_keys/picache" = {
        mode = "0600";
        owner = config.users.users.quinn.name;
        path = "${homeDirectory}/.ssh/keys/picache";
      };
    };
  };
}
