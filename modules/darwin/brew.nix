{
  homebrew = {
    enable = true;
    global.brewfile = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      extraFlags = [ "--greedy" ];
      upgrade = true;
    };

    taps = [
      "homebrew/bundle"
      "homebrew/services"
      "iina/homebrew-mpv-iina"
      "slp/krunkit"
    ];

    casks = [
      "betterdisplay"
      "element"
      "eqmac"
      "iina"
      "iterm2"
      "macfuse"
      "obsidian"
      "pearcleaner"
      "podman-desktop"
      "tailscale"
      "utm"
      "vagrant"
      "zed@preview"
    ];

    brews = [
      "age"
      "aria2"
      "awscli"
      "bat"
      "bzip2"
      "chroma"
      "cmake"
      "commitizen"
      "coreutils"
      "curl"
      "eza"
      "fd"
      "ffmpeg"
      "gcc"
      "gh"
      "git-lfs"
      "git"
      "github-mcp-server"
      "glow"
      "gnu-sed"
      "gnupg"
      "go"
      "gobject-introspection"
      "gptfdisk"
      "gum"
      "krunkit"
      "jq"
      "just"
      "ldid"
      "lf"
      "lftp"
      "libb2"
      "libffi"
      "lima"
      "llvm"
      "lzip"
      "lzo"
      "make"
      "marksman"
      "mas"
      "meson"
      "most"
      "ncdu"
      "node"
      "oci-cli"
      "openssl@3"
      "perl"
      "pipenv"
      "pipx"
      "pkg-config"
      "podman-compose"
      "podman"
      "pv"
      "qemu"
      "rbenv"
      "rclone"
      "ripgrep"
      "rsync"
      "rustup"
      "shellcheck"
      "socat"
      "tree"
      "uv"
      "watch"
      "w3m"
      "wget"
      "yq"
      "zbar"
      "zlib"
    ];
  };
}
