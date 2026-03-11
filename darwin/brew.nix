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

    brews = [
      "aria2"
      "ast-grep"
      "bat"
      "bottom"
      "bun"
      "curl"
      "eza"
      "fd"
      "fx"
      "gcc"
      "gh"
      "gist"
      "git"
      "git-lfs"
      "github-mcp-server"
      "glab"
      "glow"
      "gnu-sed"
      "gnupg"
      "go"
      "gptfdisk"
      "gum"
      "hugo"
      "jq"
      "just"
      "slp/krunkit/krunkit"
      "lima"
      "lld"
      "llvm"
      "make"
      "meson"
      "neovim"
      "node"
      "ollama"
      "openssh"
      "openssl@3"
      "pkg-config"
      "pnpm"
      "podman"
      "podman-compose"
      "pv"
      "python-lsp-server"
      "rclone"
      "ripgrep"
      "rsync"
      # "ruff"
      "rustup"
      "shellcheck"
      "shfmt"
      "superhtml"
      "tldr"
      "tmux"
      "tree"
      "uv"
      "wasm-pack"
      "wasmtime"
      "watch"
      "wget"
      "withered-magic/brew/starpls"
      "xcodes"
      "yq"
    ];
    casks = [
      "betterdisplay"
      "font-victor-mono-nerd-font"
      "ghostty@tip"
      "obsidian"
      "podman-desktop"
      "raycast"
      "tailscale-app"
      "utm@beta"
      "zed"
    ];
    taps = [
      "oven-sh/bun"
      "slp/krunkit"
    ];
  };
}
