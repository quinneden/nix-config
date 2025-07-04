{
  homebrew = {
    enable = true;
    global.brewfile = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      # extraFlags = [ "--quiet" ];
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
      "container"
      "element"
      "iina"
      "iterm2"
      "macfuse"
      "obsidian"
      "pearcleaner"
      "podman-desktop"
      "tailscale"
      "utm"
      "zed@preview"
    ];

    brews = [
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
      "fileicon"
      "gcc"
      "gh"
      "git"
      "git-lfs"
      "github-mcp-server"
      "glow"
      "gnu-sed"
      "gnupg"
      "go"
      "gobject-introspection"
      "gptfdisk"
      "gum"
      "jq"
      "just"
      "ldid"
      "lftp"
      "libb2"
      "libepoxy"
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
      "openssl@3"
      "perl"
      "pipenv"
      "pipx"
      "pkg-config"
      "podman"
      "podman-compose"
      "pv"
      "qemu"
      "rbenv"
      "rclone"
      "ripgrep"
      "rsync"
      "rustup"
      "shellcheck"
      "slp/krunkit/krunkit"
      "slp/krunkit/libkrun-efi"
      "slp/krunkit/molten-vk-krunkit"
      "slp/krunkit/virglrenderer"
      "socat"
      "tlrc"
      "tree"
      "uv"
      "watch"
      "wget"
      "yq"
      "zbar"
      "zlib"
    ];
  };
}
