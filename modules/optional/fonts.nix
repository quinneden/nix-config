{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.caskaydia-cove
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
      nerd-fonts.noto
      nerd-fonts.symbols-only
      nerd-fonts.victor-mono
    ];
  };
}
