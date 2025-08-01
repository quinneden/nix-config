{ config, inputs, ... }:

let
  secretsPath = "${inputs.secrets}/sops";
  inherit (config.users.users.quinn) home name;
in

{
  sops.secrets = {
    "passwords/quinn" = { };

    "ssh_ed25519_oc-runner" = {
      mode = "0600";
      owner = name;
      path = "${home}/.ssh/keys/oc-runner";
      sopsFile = "${secretsPath}/ssh-keys.yaml";
    };

    "ssh_ed25519_picache" = {
      mode = "0600";
      owner = name;
      path = "${home}/.ssh/keys/picache";
      sopsFile = "${secretsPath}/ssh-keys.yaml";
    };
  };
}
