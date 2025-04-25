{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.tailscale ];
  services.tailscale = {
    enable = true;
    openFirewall = true;
    extraUpFlags = [
      "--ssh"
      "--accept-dns=true"
    ];
  };
}
