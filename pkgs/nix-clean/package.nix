{
  coreutils,
  jq,
  lib,
  nh,
  stdenv,
  writeShellScriptBin,
}:

let
  esc = builtins.fromJSON ''"\u001b"'';
  GREEN = "${esc}[32m";
  RED = "${esc}[31m";
  RESET = "${esc}[0m";
  YELLOW = "${esc}[33m";

  binPath = lib.makeBinPath [
    (if stdenv.isDarwin then jq else coreutils)
    nh
  ];
in

writeShellScriptBin "nix-clean" ''
  PATH=${binPath}:$PATH

  optimize=false

  ${
    if stdenv.isDarwin then
      ''
        get_size_bytes() {
          diskutil list -plist virtual \
            | plutil -convert json -o - - \
            | jq '.AllDisksAndPartitions
                  | .[] | .APFSVolumes[]?
                  | select(.MountPoint == "/nix")
                  | .CapacityInUse'
        }
      ''
    else
      ''
        get_size_bytes() {
          df --output=used /nix | tail -n1
        }
      ''
  }

  show_help() {
    echo "Usage: nix-clean [OPTIONS]" >&2
    echo >&2
    echo "Options:" >&2
    echo "  -h, --help                     Show this help message" >&2
    echo "  -k, --keep KEEP                Specify number of past generations to keep" >&2
    echo "  -K, --keep-since KEEP_SINCE    Specify time range in which past gcroots and generations will be kept" >&2
    echo "  -o, --optimize                 Optimize the Nix store after cleaning" >&2
    echo "  -u, --used                     Show the current size of the Nix store and exit" >&2
  }

  nh_clean_in_background() {
    nh clean all --no-gcroots &>/dev/null &
    nh_pid=$!
    trap "sudo kill $nh_pid &>/dev/null" INT TERM EXIT
  }

  to_mib() {
    local bytes
    if [[ -n $1 ]]; then
      bytes=$1
    else
      read -r bytes
    fi
    awk -v b="$bytes" 'BEGIN { printf "%.2f MiB\n", b/1048576 }'
  }

  to_gib() {
    local bytes
    if [[ -n $1 ]]; then
      bytes=$1
    else
      read -r bytes
    fi
    awk -v b="$bytes" 'BEGIN { printf "%.2f GiB\n", b/1073741824 }'
  }

  get_percentage() {
    awk -v num="$bytes_diff" -v den="$initial_bytes" -v prec=2 \
      'BEGIN { printf "%.*f", prec, (num/den)*100 }'
  }

  show_diff() {
    local current_bytes bytes_diff pct
    current_bytes=$(get_size_bytes)
    bytes_diff=$((initial_bytes - current_bytes))
    pct="$(get_percentage "$bytes_diff" "$initial_bytes")%"

    if [[ $bytes_diff -gt $((1024 * 1024 * 1024)) ]]; then
      fmt=$(to_gib "$bytes_diff")
    elif [[ $bytes_diff -gt 0 ]]; then
      fmt=$(to_mib "$bytes_diff")
    else
      fmt="0.00 MiB"
    fi

    echo "$fmt, $pct"
  }

  watch_clean_until_done() {
    local clear="\e[0K"
    while kill -0 "$nh_pid" 2>/dev/null; do
      echo -ne "''${clear}Cleaning.    [ ${YELLOW}$(show_diff) removed${RESET} ]\r"; sleep 0.5
      echo -ne "''${clear}Cleaning..   [ ${YELLOW}$(show_diff) removed${RESET} ]\r"; sleep 0.5
      echo -ne "''${clear}Cleaning...  [ ${YELLOW}$(show_diff) removed${RESET} ]\r"; sleep 0.7
      echo -ne "''${clear}Cleaning     [ ${YELLOW}$(show_diff) removed${RESET} ]\r"; sleep 0.3
    done
    echo -ne "\r''${clear}"
  }

  arg_maybe() {
    local _arg="''${1:-}"
    [[ -z $_arg || $_arg == -* ]] && return 0
    echo $arg && shift
  }

  while [[ $# -gt 0 ]]; do
    arg=$1; shift
    case "$arg" in
      -h | --help)
        show_help && exit 0
        ;;
      -u | --used)
        echo -e "Nix store size: ${YELLOW}$(get_size_bytes | to_gib)${RESET}"
        exit 0
        ;;
      -o | --optimize | --optimise)
        optimize=true
        shift
        ;;
      *)
        echo "${RED}Error: Unknown option '$1'${RESET}" >&2
        show_help
        exit 1
        ;;
    esac
  done

  initial_bytes=$(get_size_bytes)
  nh_clean_in_background

  if watch_clean_until_done; then
    echo -e "${GREEN}Finished cleaning Nix store${RESET}"
    echo -e "Remaining:  ${YELLOW}$(get_size_bytes | to_gib)${RESET}"
    echo -e "Removed:    ${YELLOW}$(show_diff)${RESET}"
  fi

  if "$optimize"; then
    nix store optimise
    echo -e "${GREEN}Finished optimizing Nix store${RESET}"
  fi
''
