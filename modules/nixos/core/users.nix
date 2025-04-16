{ pkgs, ... }:
{
  users.users.quinn = {
    description = "Quinn Edenfield";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "audio"
      "i2c"
      "networkmanager"
      "video"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJyLtibXqcDXRQ8DzDUbVw71YA+k+L7fH7H3oPYyjFII"
    ];
  };
}
