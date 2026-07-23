{ inputs, ... }:

{
  den.aspects.noctalia = {
    nixos = { pkgs, ... }: {
      imports = [
        inputs.noctalia.nixosModules.default
        inputs.noctalia-greeter.nixosModules.default
      ];

      programs = {
        noctalia = {
          enable = true;
          recommendedServices.enable = true;
          systemd.enable = true;
        };

        noctalia-greeter = {
          enable = true;
          greeter-args = "";
          settings = {
            cursor = {
              path = "${pkgs.phinger-cursors}/share/icons";
              size = 24;
              theme = "phinger-cursors-dark";
            };

            keyboard.layout = "us";
          };
        };
      };
    };

    _.to-users = {
      homeManager = {
        imports = [ inputs.noctalia.homeModules.default ];

        programs.noctalia = {
          enable = true;
          package = null;
          settings = import ./_settings.nix;
        };
      };
    };
  };
}
