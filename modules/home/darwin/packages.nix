{ pkgs, ... }:
{
  home.packages = with pkgs; [
    markdown-oxide
    marksman
    nixd
    nixfmt-rfc-style
    superhtml
    vesktop
  ];
}
