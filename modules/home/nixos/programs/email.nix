{ config, ... }:
let
  himalayaGmail =
    {
      address,
      passwordFile,
      primary ? false,
    }:
    {
      enable = true;
      settings = {
        default = primary;
        email = address;
        display-name = "Quinn Edenfield";
        downloads-dir = "/home/quinn/Downloads";
        folder.aliases = {
          inbox = "INBOX";
          sent = "[Gmail]/Sent Mail";
          drafts = "[Gmail]/Drafts";
          trash = "[Gmail]/Trash";
        };
        backend = {
          type = "imap";
          host = "imap.gmail.com";
          port = 993;
          login = address;
          encryption.type = "tls";
          auth.type = "password";
          auth.cmd = "cat ${passwordFile}";
        };
        message.send.backend = {
          type = "smtp";
          host = "smtp.gmail.com";
          port = 465;
          login = address;
          encryption.type = "tls";
          auth.type = "password";
          auth.cmd = "cat ${passwordFile}";
        };
      };
    };
in
{
  accounts.email.accounts = {
    qedenfield = rec {
      address = "qedenfield@gmail.com";
      realName = "Quinn Edenfield";
      primary = true;
      himalaya = himalayaGmail {
        inherit address primary;
        passwordFile = config.sops.secrets."passwords/himalaya-qedenfield".path;
      };
    };

    quinnyxboy = rec {
      address = "quinnyxboy@gmail.com";
      realName = "Quinn Edenfield";
      himalaya = himalayaGmail {
        inherit address;
        passwordFile = config.sops.secrets."passwords/himalaya-quinnyxboy".path;
      };
    };
  };

  programs.himalaya.enable = true;
}
