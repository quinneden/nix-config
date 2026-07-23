{ den, ... }:

{
  den.aspects.qeden = {
    includes = [
      den.aspects.packages
      den.aspects.programs
      den.aspects.shells
      den.aspects.starship
      den.batteries.primary-user
      (den.batteries.user-shell "zsh")
    ];

    homeManager = {
      home.file.".hushlogin".text = "";
      home.sessionVariables.TACK_NIX_CONF_TOKENS = "1";
    };
  };
}
