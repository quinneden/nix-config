{ pkgs, ... }:
{

  fonts = {
    packages = with pkgs; [
      nerd-fonts.caskaydia-cove
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      nerd-fonts.jetbrains-mono
      nerd-fonts.noto
      nerd-fonts.symbols-only
      nerd-fonts.victor-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      openmoji-color
      source-sans
      twemoji-color-font
    ];
  };
}
