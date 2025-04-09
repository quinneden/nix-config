{
  outputs,
  userConfig,
  pkgs,
  ...
}:
{
  imports = [
    ../../external/hm
    ../misc/qt
    ../programs/aerospace
    ../programs/alacritty
    ../programs/atuin
    ../programs/bat
    ../programs/brave
    ../programs/btop
    ../programs/fastfetch
    ../programs/fzf
    ../programs/git
    ../programs/go
    # ../programs/gpg
    # ../programs/k9s
    # ../programs/krew
    ../programs/lazygit
    # ../programs/neovim
    # ../programs/obs-studio
    ../programs/rust
    # ../programs/saml2aws
    # ../programs/starship
    # ../programs/telegram
    ../programs/tmux
    # ../programs/zoom
    ../programs/zsh
    ../scripts
    ../services/easyeffects
    ../services/ulauncher
  ];

  # Nixpkgs configuration
  nixpkgs = {
    overlays = [ outputs.overlays.stable-packages ];

    config = {
      allowUnfree = true;
    };
  };

  # Home-Manager configuration for the user's home environment
  home = {
    username = "${userConfig.name}";
    homeDirectory =
      if pkgs.stdenv.isDarwin then "/Users/${userConfig.name}" else "/home/${userConfig.name}";
  };

  # Ensure common packages are installed
  home.packages =
    with pkgs;
    [
      anki-bin
      awscli2
      cachix
      dig
      du-dust
      eza
      fd
      inputs.shellpers.packages.${pkgs.system}.metapackage
      jq
      kubectl
      lazydocker
      nh
      nix-prefetch-git
      nix-prefetch-github
      nixfmt-rfc-style
      openconnect
      pipenv
      python3
      qemu
      ripgrep
      terraform
    ]
    ++ lib.optionals stdenv.isDarwin [
      colima
      docker
      hidden-bar
      raycast
    ]
    ++ lib.optionals (!stdenv.isDarwin) [
      pavucontrol
      pulseaudio
      tesseract
      unzip
      wl-clipboard
    ];

  # Catpuccin flavor and accent
  catppuccin = {
    flavor = "macchiato";
    accent = "lavender";
  };
}
