{ config, lib, ... }:

let
  inherit (lib)
    filterAttrs
    literalExpression
    mapAttrsToList
    mkDefault
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  inherit (import ./config.nix { inherit lib; }) mkCustomConfig;

  cfg = config.determinate-nix;

  flakeRefFormat = ''
    The format of flake references is described in {manpage}`nix3-flake(1)`.
  '';

  semanticConfType =
    with types;
    let
      confAtom =
        nullOr (oneOf [
          bool
          int
          float
          str
          path
          package
        ])
        // {
          description = "Nix configuration atom (null, Boolean, integer, float, list, derivation, path, attribute set)";
        };
    in
    attrsOf (either confAtom (listOf confAtom));

  # Settings that Determinate Nix handles for you
  disallowedOptions = [
    "always-allow-substitutes"
    "bash-prompt-prefix"
    "netrc-file"
    "ssl-cert-file"
    "upgrade-nix-store-path-url"
  ];
in
{
  options.determinate-nix = {
    enable = mkEnableOption "determinate-nix module" // {
      default = true;
    };

    settings = mkOption {
      type = types.submodule {
        options = { };

        # Support "free-form" options
        freeformType = semanticConfType;
      };
      default = { };
    };

    registry = mkOption {
      type = types.attrsOf (
        types.submodule (
          let
            referenceAttrs =
              with types;
              attrsOf (oneOf [
                str
                int
                bool
                path
                package
              ]);
          in
          { config, name, ... }:
          {
            options = {
              from = mkOption {
                type = referenceAttrs;
                example = {
                  type = "indirect";
                  id = "nixpkgs";
                };
                description = ''
                  The flake reference to be rewritten.

                  ${flakeRefFormat}
                '';
              };
              to = mkOption {
                type = referenceAttrs;
                example = {
                  type = "github";
                  owner = "my-org";
                  repo = "my-nixpkgs";
                };
                description = ''
                  The flake reference {option}`from` is rewritten to.

                  ${flakeRefFormat}
                '';
              };
              flake = mkOption {
                type = types.nullOr types.attrs;
                default = null;
                example = literalExpression "nixpkgs";
                description = ''
                  The flake input {option}`from` is rewritten to.
                '';
              };
              exact = mkOption {
                type = types.bool;
                default = true;
                description = ''
                  Whether the {option}`from` reference needs to match exactly. If set,
                  a {option}`from` reference like `nixpkgs` does not
                  match with a reference like `nixpkgs/nixos-20.03`.
                '';
              };
            };
            config = {
              from = mkDefault {
                type = "indirect";
                id = name;
              };
              to = mkIf (config.flake != null) (
                mkDefault (
                  {
                    type = "path";
                    path = config.flake.outPath;
                  }
                  // filterAttrs (n: _: n == "lastModified" || n == "rev" || n == "narHash") config.flake
                )
              );
            };
          }
        )
      );
      default = { };
      description = ''
        A system-wide flake registry.

        See {manpage}`nix3-registry(1)` for more information.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = lib.all (key: !lib.hasAttr key config.determinate-nix.settings) disallowedOptions;
        message = ''
          These settings are not allowed in `determinate-nix.settings`:
            ${lib.concatStringsSep ", " disallowedOptions}
        '';
      }
    ];

    environment.etc = {
      "nix/nix.nix-darwin.conf" = mkIf (cfg.settings != { }) {
        text = lib.concatStringsSep "\n" (
          [ "# This is generated from the configuration defined in 'config.determinate-nix.settings'." ]
          ++ mkCustomConfig config.determinate-nix.settings
        );
      };

      "nix/registry.json" = mkIf (cfg.registry != { }) {
        text = builtins.toJSON {
          version = 2;
          flakes = mapAttrsToList (n: v: { inherit (v) from to exact; }) cfg.registry;
        };
      };
    };
  };
}
