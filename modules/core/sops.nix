{ inputs, ... }:

let
  secretsPath = "${inputs.secrets}/sops";
in

{
  imports = [ inputs.sops-nix.darwinModules.default ];

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
    };
  };
}
