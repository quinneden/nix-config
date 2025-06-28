{ lib, pkgs, ... }:
let
  inherit (pkgs) stdenv fetchgit;

  nixfmt-shim = pkgs.writeShellScriptBin "nixfmt-shim" ''
    read -d'EOF' -ra err < <(${lib.getExe pkgs.nixfmt-rfc-style} "$@" 2>&1 | sed '2,4d')

    loc=$(grep -oE '[0-9]+:[0-9]+'<<<"''${err[0]}")
    line=$(awk -F':' '{print $1}'<<<"$loc")
    col=$(awk -F':' '{print $2}'<<<"$loc")

    err_str=$(printf '%s ' "''${err[@]:1}")

    unexp="''${err_str%%expecting*}"

    exp="$(grep -oe 'expecting.*$' <<< "$err_str")"

    if ! ${lib.getExe pkgs.nixfmt-rfc-style} -cq "$@"; then
      echo -n "Error: line $line, col $col: $unexp; $exp." >&2
      exit 1
    else
      ${lib.getExe pkgs.nixfmt-rfc-style} -qv "$@"
    fi
  '';
in
stdenv.mkDerivation (finalAttrs: {
  name = "micro-autofmt";
  version = "2.0.3";
  src = fetchgit {
    url = "https://github.com/quinneden/micro-autofmt";
    rev = "refs/heads/main";
    hash = "sha256-x8va2mcQAK0ProtfYOdDuIO3LxEu8yNX10rm2fWpLEw=";
  };
  buildInputs = [ nixfmt-shim ];
  makeFlags = [ "prefix=${placeholder "out"}" ];
  installPhase = ''
    rm $out/bin/nixfmt_shim
    cp ${nixfmt-shim}/bin/nixfmt-shim $out/bin/nixfmt_shim
  '';
})
