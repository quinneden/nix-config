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
      confirm-close-surface = false;
      copy-on-select = false;
      cursor-style = "bar";
      font-family = "CaskaydiaCove Nerd Font Mono";
      font-feature = [
        "liga"
        "calt"
      ];
      gtk-single-instance = false;
      gtk-titlebar = false;
      theme = "light:charmful-light,dark:charmful-dark";
      window-decoration = "auto";
      window-height = 26;
      window-padding-x = 12;
      window-padding-y = 6;
      window-theme = "system";
      window-width = 90;
      keybind = mkBinds {
        "ctrl+end" = "scroll_to_bottom";
        "ctrl+home" = "scroll_to_top";
        "ctrl+shift+down" = "scroll_page_lines:3";
        "ctrl+shift+up" = "scroll_page_lines:-3";
        "performable:shift+down" = "scroll_page_lines:1";
        "performable:shift+up" = "scroll_page_lines:-1";
        "unconsumed:shift+end" = "adjust_selection:end_of_line";
        "unconsumed:shift+home" = "adjust_selection:beginning_of_line";
        "performable:ctrl+c" = "copy_to_clipboard";
      };
    };
  };

  home.sessionVariables.TERMINAL = "ghostty";
}
