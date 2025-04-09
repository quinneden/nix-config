{ inputs, ... }:
{
  # When applied, the stable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.stable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  default =
    final: prev:
    prev.lib.packagesFromDirectoryRecursive {
      callPackage = prev.lib.callPackageWith final;
      directory = ../pkgs;
    }
    // {
      pure-prompt = prev.pure-prompt.overrideAttrs {
        src = prev.fetchFromGitHub {
          owner = "quinneden";
          repo = "pure";
          rev = "refs/heads/nix3-shell-prompt";
          hash = "sha256-dv2neCnIGaIJm0ez9O9VORaDSJ4O9GAegwgo5G7rWeA=";
        };
      };
    };
}
