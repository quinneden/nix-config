{
  den.aspects.blanche.darwin = {
    homebrew = {
      enable = true;
      global.autoUpdate = true;
      global.brewfile = true;
      onActivation.cleanup = "zap";
      onActivation.extraFlags = [ "--quiet" ];

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
        "lima"
        "lld"
        "llvm"
        "luarocks"
        "make"
        "meson"
        "mole"
        "neovim"
        "node"
        "nushell"
        "ollama"
        "openjdk"
        "openssh"
        "openssl@3"
        "pkg-config"
        "pnpm"
        "podman"
        "podman-compose"
        "pv"
        "python-lsp-server"
        "rclone"
        "restic"
        "ripgrep"
        "rsync"
        "rustup"
        "shellcheck"
        "shfmt"
        "krunkit"
        "superhtml"
        "tldr"
        "tmux"
        "tree"
        "uv"
        "wasm-pack"
        "wasmtime"
        "watch"
        "wget"
        "xcodes"
        "yq"
      ];

      casks = [
        "betterdisplay"
        "font-victor-mono-nerd-font"
        "ghostty@tip"
        "obsidian"
        "podman-desktop"
        "tailscale-app"
        "utm@beta"
        "zed"
      ];

      taps = [
        "oven-sh/bun"
        "slp/krun"
      ];
    };
  };
}
