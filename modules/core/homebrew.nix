{
  homebrew = {
    enable = true;

    global = {
      autoUpdate = true;
      brewfile = true;
    };

    onActivation = {
      upgrade = true;
      cleanup = "zap";
      extraFlags = [ "--quiet" ];
    };

    taps = [ "withered-magic/brew" ];

    casks = [
      "iterm2"
      "zen"
    ];

    brews = [
      "bat"
      "bazelisk"
      "curl"
      "eza"
      "fd"
      "gcc"
      "gh"
      "git"
      "git-lfs"
      "github-mcp-server"
      "glow"
      "gnu-sed"
      "gnupg"
      "gptfdisk"
      "jq"
      "just"
      "lima"
      "llvm"
      "make"
      "meson"
      "node"
      "openssl@3"
      "pkg-config"
      "pnpm"
      "pv"
      "rclone"
      "ripgrep"
      "rsync"
      "uv"
      "watch"
      "wget"
      "withered-magic/brew/starpls"
      "yq"
    ];
  };
}
