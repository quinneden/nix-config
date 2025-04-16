{ prev, ... }:
{
  common = {
    pure-prompt = prev.pure-prompt.overrideAttrs {
      src = prev.fetchFromGitHub {
        owner = "quinneden";
        repo = "pure";
        rev = "refs/heads/nix3-shell-prompt";
        hash = "sha256-6xLBcJEi31RBEt9tfHumeiS8D195SK5ZWqZ6bzxH3Vc=";
      };
    };
  };

  darwin = { };

  linux = {
    base16-schemes = prev.base16-schemes.overrideAttrs {
      version = "spec-0.11";
      src = prev.fetchFromGitHub {
        owner = "tinted-theming";
        repo = "schemes";
        rev = "refs/heads/spec-0.11";
        hash = "sha256-WAt2QPvv/gy9oTpk0iUJOxB0rDLE+vqLD3a7k9wcOvE=";
      };
    };
  };
}
