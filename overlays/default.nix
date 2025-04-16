{
  default =
    final: prev:
    (
      prev.lib.packagesFromDirectoryRecursive {
        callPackage = prev.lib.callPackageWith final;
        directory = ../pkgs/common;
      }
      // (import ./overrides.nix { inherit prev; }).common
    );

  darwin =
    final: prev:
    (
      prev.lib.packagesFromDirectoryRecursive {
        callPackage = prev.lib.callPackageWith final;
        directory = ../pkgs/darwin;
      }
      // (import ./overrides.nix { inherit prev; }).darwin
    );

  linux =
    final: prev:
    (
      prev.lib.packagesFromDirectoryRecursive {
        callPackage = prev.lib.callPackageWith final;
        directory = ../pkgs/linux;
      }
      // (import ./overrides.nix { inherit prev; }).linux
    );
}
