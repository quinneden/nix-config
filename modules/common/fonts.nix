{
  lib,
  pkgs,
  inputs,
  ...
}:
{

  fonts = {
    packages =
      with pkgs;
      [
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
      ]
      ++ lib.optional stdenv.isDarwin inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;

    enableDefaultPackages = false;

    fontconfig = {
      defaultFonts = {
        monospace = [
          "CaskaydiaCove Nerd Font Mono"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "SFProDisplay Nerd Font"
          "Noto Color Emoji"
        ];
        serif = [
          "SFProDisplay Nerd Font"
          "Noto Color Emoji"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
