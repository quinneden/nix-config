{
  programs.atuin = {
    enable = false;
    daemon.enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      # inline_height = 10;
      # inline_height_shell_up_key_binding = 3;
      invert = false;
      search_mode = "daemon-fuzzy";
      style = "full";
      update_check = false;
    };
  };
}
