{ den, inputs, ... }:

{
  imports = [ inputs.den.flakeModule ];

  den.default.includes = [
    den.batteries.define-user
    den.batteries.hostname
  ];

  den.default.darwin.system.stateVersion = 6;
  den.default.homeManager.home.stateVersion = "26.11";
  den.default.nixos.system.stateVersion = "26.11";

  den.schema.host.includes = [ den.aspects.core ];
}
