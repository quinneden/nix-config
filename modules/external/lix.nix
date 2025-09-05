{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.lix;
in

{
  options.lix.enable = lib.mkEnableOption "lix (from nixpkgs) overlay" // {
    default = true;
  };

  config = lib.mkIf cfg.enable {
    nix.package = pkgs.lixPackageSets.latest.lix;
    # nixpkgs.overlays = [
    #   (final: prev: {
    #     inherit (final.lixPackageSets.latest)
    #       aws-sdk-cpp
    #       boehmgc
    #       colmena
    #       editline
    #       nix-direnv
    #       nix-eval-jobs
    #       nix-fast-build
    #       nixpkgs-review
    #       ;
    #   })
    # ];
  };
}
