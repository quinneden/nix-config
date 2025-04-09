{ inputs, userConfig, ... }:
{
  # Install git via home-manager module
  programs.git = {
    enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "micro";
      credential.helper = "store";
      github.user = "quinneden";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      url = {
        "https://oauth2:${inputs.secrets.git.token}@github.com" = {
          insteadOf = "https://github.com";
        };
      };
    };
    ignores = [
      ".DS_Store"
      ".direnv"
      "result"
      "result*"
      ".env"
      ".env.*"
    ];
    signing.format = "ssh";
    userName = userConfig.fullName;
    userEmail = userConfig.email;
  };

  # Enable catppuccin theming for git delta
  catppuccin.delta.enable = true;
}
