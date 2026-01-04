{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.amp
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.catnip
  ];

  system = {
    primaryUser = "William.Edenfield";

    defaults.trackpad.ActuationStrength = 0;

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    stateVersion = 6;
  };

  networking.hostName = "qe-mbp";
}
