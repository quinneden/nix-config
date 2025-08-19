{ darwinConfig, ... }:

{
  imports = darwinConfig.lib.import.scanPaths ./.;
}
