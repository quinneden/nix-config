{
  description = "nix-darwin and nixos configurations using den";

  outputs =
    { self }:
    let
      inputs = import ./.tack;
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs self; } {
      debug = true;
      flake.overlays.default = import ./pkgs;
      imports = [ (inputs.import-tree ./modules) ];
    };
}
