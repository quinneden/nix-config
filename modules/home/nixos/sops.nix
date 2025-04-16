{ pkgs, ... }:
let
  homeDir = "${if pkgs.stdenv.isDarwin then "/Users" else "/home"}/quinn";
in
{
  sops = {
    secrets = {
      "passwords/himalaya-qedenfield" = {
        path = "${homeDir}/.config/himalaya/auth-qedenfield";
      };
      "passwords/himalaya-quinnyxboy" = {
        path = "${homeDir}/.config/himalaya/auth-quinnyxboy";
      };
    };
  };
}
