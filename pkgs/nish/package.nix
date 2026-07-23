{ writeShellScriptBin }:

writeShellScriptBin "nish" ''
  declare -a extra_args pkgs

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --arg | --argstr)
        [[ $# -ge 3 ]] && extra_args+=("$1" "$2" "$3") && shift 3 || { echo "Error: $1 requires two arguments" >&2; exit 1; }
        ;;
      --expr | -E | --command | -c)
        [[ $# -ge 2 ]] && extra_args+=("$1" "$2") && shift 2 || { echo "Error: $1 requires an argument" >&2; exit 1; }
        ;;
      -*)
        extra_args+=("$1")
        shift
        ;;
      *)
        regex='^[[:alnum:](.|/)]+(:|#).+'
        if [[ $1 =~ $regex ]]; then
          pkgs+=("$1")
        else
          pkgs+=("nixpkgs#$1")
        fi
        shift
        ;;
    esac
  done

  name="nix-shell" nix shell "''${pkgs[@]}" "''${extra_args[@]}"
''
