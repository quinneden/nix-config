{
  description = "nix-darwin and nixos configurations using den";

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      debug = true;
      imports = [ (inputs.import-tree ./modules) ];
    };

  inputs = {
    darwin.url = "github:nix-darwin/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    den.url = "github:denful/den";
    determinate.url = "github:determinatesystems/determinate";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    import-tree.url = "github:denful/import-tree";
    nil.url = "github:oxalica/nil";
    nixd.url = "github:nix-community/nixd";
    nixos-apple-silicon.url = "github:nix-community/nixos-apple-silicon";
    nixos-apple-silicon.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    noctalia.url = "github:noctalia-dev/noctalia";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";
    noctalia-greeter.url = "github:noctalia-dev/noctalia-greeter";
    noctalia-greeter.inputs.nixpkgs.follows = "nixpkgs";
    shellpers.url = "github:quinneden/shellpers";
    shellpers.inputs.nixpkgs.follows = "nixpkgs";
    virby.url = "github:quinneden/virby-nix-darwin";
    virby.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.home-manager.follows = "home-manager";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };
}
