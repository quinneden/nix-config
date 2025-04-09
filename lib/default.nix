{ lib, ... }:

with lib;

{
  scanPaths =
    path:
    map (f: (path + "/${f}")) (
      builtins.attrNames (
        filterAttrs (
          path: _type: (_type == "directory") || ((path != "default.nix") && (hasSuffix ".nix" path))
        ) (builtins.readDir path)
      )
    );
}
