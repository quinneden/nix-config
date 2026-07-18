{
  den.aspects.programs = {
    homeManager = {
      programs = {
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };

        eza.enable = true;

        git = {
          enable = true;
          ignores = [
            "*.bck"
            ".direnv"
            ".DS_Store"
            ".env"
            ".env.*"
            ".gemini"
            "result"
            "result*"
          ];

          includes = [ { path = "~/.config/git/aliases"; } ];
          signing.format = "ssh";
          settings = {
            color.ui = true;
            core.editor = "micro";
            core.excludesfile = "~/.config/git/ignore";
            core.ui = true;
            credential.helper = "store";
            github.user = "quinneden";
            index.version = "4";
            init.defaultBranch = "main";
            push.autoSetupRemote = true;
            rerere.enabled = true;
            user.email = "quinn@qeden.dev";
            user.name = "Quinn Edenfield";
          };
        };

        nh = {
          enable = true;
          clean = {
            enable = true;
            dates = "daily";
            extraArgs = "--keep-since 7d";
          };

          darwinFlake = "/Users/qeden/.dotfiles";
          flake = "/home/qeden/.dotfiles";
        };

        micro = {
          enable = true;
          settings = {
            autoclose = true;
            autosu = true;
            colorscheme = "simple";
            comment = true;
            diff = true;
            ftoptions = true;
            initlua = true;
            linter = true;
            literate = true;
            parsecursor = true;
            reload = "auto";
            rmtrailingws = true;
            saveundo = true;
            tabhighlight = true;
            tabsize = 2;
            tabstospaces = true;
          };
        };

        pyenv.enable = true;
        zoxide.enable = true;
      };
    };
  };
}
