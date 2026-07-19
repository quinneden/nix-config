{ inputs, ... }:

{
  den.aspects.asahi = {
    nixos = { pkgs, ... }: {
      imports = [ inputs.nixos-apple-silicon.nixosModules.default ];

      environment.systemPackages = with pkgs; [
        asahi-audio
        asahi-bless
        asahi-btsync
        asahi-fwextract
        asahi-wifisync
      ];

      hardware.asahi = {
        enable = true;
        extractPeripheralFirmware = true;
        peripheralFirmwareDirectory = pkgs.fetchzip {
          url = "https://f.qeden.me/fw/asahi-fw-20260719.tgz";
          hash = "sha256-UbuNKprCxJBqKWX7cfXFNXor57oh3rMJiUmCN+NxyDw=";
        };
      };
    };
  };
}
