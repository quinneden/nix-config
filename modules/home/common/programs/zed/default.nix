{ pkgs, ... }:
let
  pythonEnv = pkgs.python3.withPackages (
    ps: with ps; [
      beautifulsoup4
      boto3
      colorama
      ipykernel
      ipython
      jedi
      pip
      pycodestyle
      pyflakes
      pytest
      pyyaml
      requests
      rope
      yapf
    ]
  );
in
{
  imports = [ ./module.nix ];

  programs.zed-editor = {
    enable = pkgs.stdenv.isLinux;
    package = pkgs.zed-editor-fhs;

    extraPackages = with pkgs; [
      markdown-oxide
      marksman
      nixd
      nixfmt-rfc-style
      pythonEnv
      superhtml
    ];

    extraThemes = [
      ./themes/AyuQ.json
      ./themes/MonolithHighlighted.json
    ];
  };
}
