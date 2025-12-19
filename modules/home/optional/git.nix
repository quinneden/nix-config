{
  programs.git = {
    enable = true;

    ignores = [
      ".DS_Store"
      ".direnv"
      "result"
      "result*"
      ".env"
      ".env.*"
    ];

    signing.format = "ssh";

    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "store";
      github.user = "quinneden";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };

    userName = "Quinn Edenfield";
  };
}
