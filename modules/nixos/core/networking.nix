{
  networking = {
    wireless.iwd = {
      enable = true;
      settings = {
        IPv6.Enabled = true;
        Settings.AutoConnect = true;
        General.EnableNetworkConfiguration = true;
      };
    };
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };
}
