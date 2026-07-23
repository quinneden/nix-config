final: prev: prev.lib.packagesFromDirectoryRecursive {
  directory = ./.;
  inherit (final) callPackage;
}
