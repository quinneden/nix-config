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
      "slp/krunkit"
      "slp/krun"
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
      "zed@preview"
    ];

    brews = [
      "act"
      "age"
      "aria2"
      "awscli"
      "bat"
      "black"
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
      "git-crypt"
      "git-lfs"
      "git"
      "glab"
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
      "krunvm"
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
      "p7zip"
      "perl"
      "pipenv"
      "pipx"
      "pyenv"
      "pkg-config"
      "pnpm"
      "podman-compose"
      "podman-tui"
      "podman"
      "pv"
      "qemu"
      "rbenv"
      "rclone"
      "rich"
      "ripgrep"
      "rsync"
      "rustup"
      "shc"
      "shellcheck"
      "tree"
      "w3m"
      "wget"
      "yazi"
      "yq"
      "zbar"
      "zlib"
    ];
  };
}
