{ lib, pkgs, ... }:
let
  mkBinds = { ... }@keys: lib.mapAttrsToList (name: value: "${name}=${value}") keys;
  mkTheme =
    colorscheme: with colorscheme; {
      background = "${bg}";
      foreground = "${fg}";
      cursor-color = "${cursor.bg}";
      cursor-text = "${cursor.fg}";
      selection-background = "${selection.bg}";
      selection-foreground = "${selection.fg}";
      palette = [
        "0=${black}"
        "1=${red}"
        "2=${green}"
        "3=${yellow}"
        "4=${blue}"
        "5=${magenta}"
        "6=${cyan}"
        "7=${white}"
        "8=${bright.black}"
        "9=${bright.red}"
        "10=${bright.green}"
        "11=${bright.yellow}"
        "12=${bright.blue}"
        "13=${bright.magenta}"
        "14=${bright.cyan}"
        "15=${bright.white}"
      ];
    };
in
{
  programs.ghostty = {
    enable = true;
    themes = {
      charmful-light = mkTheme (import ../colors.nix { scheme = "light"; });
      charmful-dark = mkTheme (import ../colors.nix { scheme = "dark"; });
    };

    settings = {
      command = "${pkgs.zsh}/bin/zsh";
      font-family = "CaskaydiaCove Nerd Font";
      font-feature = [
        "liga"
        "calt"
      ];
      theme = "light:charmful-light,dark:charmful-dark";
      window-padding-x = 12;
      window-padding-y = 6;
      window-decoration = "auto";
      window-theme = "system";
      window-height = 26;
      window-width = 90;
      copy-on-select = false;
      gtk-single-instance = false;
      gtk-titlebar = false;
      confirm-close-surface = false;
      keybind = mkBinds {
        "ctrl+shift+left" = "adjust_selection:beginning_of_line";
        "ctrl+shift+right" = "adjust_selection:end_of_line";
        "ctrl+up" = "scroll_page_lines:-1";
        "ctrl+down" = "scroll_page_lines:1";
        "ctrl+shift+up" = "scroll_page_lines:-3";
        "ctrl+shift+down" = "scroll_page_lines:3";
      };
    };
  };

  home.sessionVariables.TERMINAL = "ghostty";
}
