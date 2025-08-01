{ lib, ... }:

{
  lib = {
    import = {
      scanPaths =
        p:
        map (s: lib.path.append p s) (
          builtins.attrNames (
            lib.filterAttrs (
              name: type:
              (type == "directory" && !((lib.hasPrefix "." name) || (lib.hasSuffix ".bck" name)))
              || ((name != "default.nix") && (lib.hasSuffix ".nix" name))
            ) (builtins.readDir p)
          )
        );
    };
  };
}
