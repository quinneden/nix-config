{
  den.aspects.packages = {
    homeManager = { pkgs, ... }: {
      home.packages =
        let
          nixfmt-tree =
            (pkgs.nixfmt-tree.override { settings.formatter.nixfmt.options = [ "--strict" ]; }).overrideAttrs
              (old: {
                buildCommand = (
                  old.buildCommand
                  + ''
                    mv $out/bin/treefmt $out/bin/nixfmt-tree
                  ''
                );
              });
        in
        with pkgs;
        [
          bash-language-server
          bat
          cachix
          fd
          file
          gawk
          gnutar
          gptfdisk
          nerd-fonts.noto
          nerd-fonts.ubuntu-sans
          nerd-fonts.victor-mono
          nh
          nil
          nish
          nix-clean
          nix-prefetch-git
          nix-prefetch-github
          nixd
          nixfmt
          nixfmt-tree
          qemu
          ripgrep
          tree-sitter
        ];
    };

    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        git
        wget
        wl-clipboard-rs
        wl-gammactl
      ];
    };
  };
}
