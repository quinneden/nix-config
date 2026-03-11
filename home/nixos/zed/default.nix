{
  inputs,
  pkgs,
  self,
  ...
}:
{
  programs.zed-editor = {
    enable = true;

    extraPackages = with pkgs; [
      basedpyright
      ruff
      just
      nil
      nixd
      shfmt
      tombi
    ];

    extensions = [
      "basher"
      "dockerfile"
      "env"
      "git-firefly"
      "github-theme"
      "html"
      "ini"
      "just"
      "log"
      "make"
      "mcp-server-context7"
      "mcp-server-github"
      "nix"
      "one-dark-pro"
      "symbols"
      "tombi"
      "toml"
      "ultimate-dark-neo"
      "xml"
    ];

    mutableUserSettings = true;
    mutableUserKeymaps = true;

    userSettings = import ./settings.nix { inherit inputs self; };
    userKeymaps = import ./keymaps.nix;
  };
}
