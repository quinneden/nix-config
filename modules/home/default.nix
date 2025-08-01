{ darwinConfig, inputs, ... }:

{
  imports = (darwinConfig.lib.import.scanPaths ./.) ++ [
    ./external
    inputs.mac-app-util.homeManagerModules.default
  ];
}
