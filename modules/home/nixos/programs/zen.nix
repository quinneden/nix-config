{ pkgs, inputs, ... }:
let
  zen-wayland-wrapped = pkgs.symlinkJoin {
    name = "zen-browser-wayland";
    paths = [ inputs.zen-browser.packages."${pkgs.system}".default ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/zen \
        --set MOZ_ENABLE_WAYLAND 1
    '';
  };
in
{
  home.packages = [ zen-wayland-wrapped ];
}
