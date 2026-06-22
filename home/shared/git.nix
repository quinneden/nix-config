{
  programs.git = {
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
}
