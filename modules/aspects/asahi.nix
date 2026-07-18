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
        peripheralFirmwareDirectory = pkgs.fetchzip {
          url = "https://f.qeden.me/fw/asahi-fw-20260716.tgz";
          hash = "sha256-zMULUmrjQeajYn+2/mYmWoJDP4/CzmSJqxbVwky2zC4=";
        };
      };

      # nixpkgs.overlays = [
      #   (final: _: {
      #     # Temporary override to fix incorrect src hash in upstream
      #     # https://github.com/nix-community/nixos-apple-silicon/blob/main/apple-silicon-support/packages/linux-asahi/default.nix#L37
      #     linux-asahi =
      #       inputs.nixos-apple-silicon.packages.${pkgs.stdenv.hostPlatform.system}.linux-asahi.overrideAttrs
      #         {
      #           src = final.fetchFromGitHub {
      #             owner = "AsahiLinux";
      #             repo = "linux";
      #             tag = "asahi-7.0.13-1";
      #             hash = "sha256-vXi7c1NWty/I6v1++j/Glnar1DJE6zeUfALZOuhV9fY=";
      #           };
      #         };
      #   })
      # ];
    };
  };
}
