{
  homebrew = {
    enable = true;
    caskArgs.language = "en-US.UTF-8";
    global.brewfile = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      extraFlags = [ "--quiet" ];
      upgrade = true;
    };

    taps = [
      "homebrew/bundle"
      "homebrew/services"
      "deskflow/homebrew-tap"
    ];

    casks = [
      "betterdisplay"
      "deskflow"
      "element"
      "eqmac"
      "iterm2"
      "macfuse"
      "obsidian"
      "pearcleaner"
      "podman-desktop"
      "tailscale"
      "utm"
      "vagrant"
    ];

    brews = [
      "age"
      "aria2"
      "awscli"
      "bat"
      "bzip2"
      "chroma"
      "cmake"
      "coreutils"
      "curl"
      "eza"
      "fd"
      "ffmpeg"
      "gcc"
      "gh"
      "git-lfs"
      "git"
      "glow"
      "gnu-sed"
      "gnupg"
      "go"
      "gobject-introspection"
      "gptfdisk"
      "gum"
      "ipython"
      "jq"
      "just"
      "ldid"
      "lf"
      "lftp"
      "libb2"
      "libffi"
      "libvirt"
      "lima"
      "llvm"
      "lzip"
      "lzo"
      "make"
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
      "podman-tui"
      "podman"
      "pv"
      "qemu"
      "rbenv"
      "rclone"
      "ripgrep"
      "rsync"
      "rustup"
      "shellcheck"
      "tree"
      "w3m"
      "wget"
      "yq"
      "zbar"
      "zlib"
    ];
  };
}
