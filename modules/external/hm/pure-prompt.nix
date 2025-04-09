{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkPackageOption mkIf;

  cfg = config.programs.zsh.pure-prompt;
in
{
  options.programs.zsh.pure-prompt = {
    enable = mkEnableOption "Pretty, minimal and fast ZSH prompt";

    package = mkPackageOption pkgs "pure-prompt" { };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    programs.zsh.initExtra = ''
      fpath+=(${cfg.package}/share/zsh/site-functions)

      autoload -U promptinit; promptinit
      prompt pure
    '';
  };
}
