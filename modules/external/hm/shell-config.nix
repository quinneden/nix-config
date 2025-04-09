{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin;
  cfg = config.shellConfig;

  commonAliases = {
    cddf = "cd $dotdir";
    cddl = "cd ~/Downloads";
    gst = "git status";
    gsur = "git submodule update --init --recursive";
    l = "eza -la --group-directories-first";
    ll = "eza -glAh --octal-permissions --group-directories-first";
    ls = "eza -A";
    push = "git push";
    zed = "zeditor";
  };

  commonVariables = {
    dotdir = "$HOME/.dotfiles";
    EDITOR = "micro";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    MICRO_TRUECOLOR = "1";
  };

  darwinAliases = {
    lc = "limactl";
    reboot = "sudo reboot";
    sed = "gsed";
    shutdown = "sudo shutdown -h now";
    darwin-man = "man configuration.nix";
  };

  linuxAliases = {
    bs = "stat -c%s";
    code = "codium";
    db = "distrobox";
    tree = "eza -ATL3 --git-ignore";
  };

  darwinVariables = {
    PATH = "/run/current-system/sw/bin:/etc/profiles/per-user/quinn/bin:/Users/quinn/.local/bin:\${PATH:+$PATH}";
    TMPDIR = "/tmp";
    PAGER = "less";
    LESS = "-RF";
  };

  linuxVariables = {
    NIXOS_CONFIG = "$HOME/.dotfiles";
    NH_FLAKE = "$HOME/.dotfiles";
  };
in
with lib;
{
  options.shellConfig = {
    enable = mkEnableOption "enable my personal shell configuration.";
    # isDarwin = mkOption {
    #   type = lib.types.bool;
    #   default = false;
    # };
    bash = {
      enable = mkEnableOption "enable bash configuration." // {
        default = false;
      };
    };
    zsh = {
      enable = mkEnableOption "enable zsh configuration." // {
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.bash = mkIf cfg.bash.enable {
      enable = true;
      enableCompletion = true;
      shellAliases = commonAliases // (if isDarwin then darwinAliases else linuxAliases);
      bashrcExtra = ''
        PS1="\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[0m\] \$ "
        HISTCONTROL=ignoredups:erasedups
        shopt -s histappend
        PROMPT_COMMAND='history -a; history -n'
        bind '"\e[A": history-search-backward'
        bind '"\e[B": history-search-forward'
      '';
    };

    programs.zsh = mkIf cfg.zsh.enable {
      enable = true;
      dotDir = ".config/zsh";
      shellAliases = commonAliases // (if isDarwin then darwinAliases else linuxAliases);
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.path = "${config.xdg.configHome}/zsh/.zsh_history";

      oh-my-zsh = {
        enable = true;
        plugins = [
          "colored-man-pages"
          "direnv"
          "eza"
          "fzf"
          "${optionalString isDarwin "iterm2"}"
          "zoxide"
        ];
        custom = "${config.xdg.configHome}/zsh";
      };

      initExtraBeforeCompInit = ''
        fpath+=(
          ${config.nix.package}/share/zsh/site-functions
          /etc/profiles/per-user/quinn/share/zsh/site-functions
          ${config.xdg.configHome}/zsh/completions
          ${optionalString isDarwin "/opt/homebrew/share/zsh/site-functions"}
        )
      '';

      initExtra = ''
        fpath+=(${pkgs.pure-prompt}/share/zsh/site-functions)
        autoload -U promptinit; promptinit
        prompt pure

        for f ($HOME/.config/zsh/functions/*(N.)); do source $f; done

        ${optionalString isDarwin "[[ $PATH =~ '/nix/store' ]] || eval $(/opt/homebrew/bin/brew shellenv)"}
      '';

      sessionVariables = commonVariables // (if isDarwin then darwinVariables else linuxVariables);
    };
  };
}
