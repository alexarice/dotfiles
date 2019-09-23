{ config, ... }:

{
  accounts.email.accounts = {
    hotmail = rec {
      primary = true;
      address = "alexrice999@hotmail.co.uk";
      userName = address;
      realName = "Alex Rice";
      passwordCommand = "${config.scripts}/bw-get.fish login.live.com";
      offlineimap.enable = true;
      imap = {
        host = "imap-mail.outlook.com";
        tls.enable = true;
      };
      notmuch.enable = true;
    };
  };

  programs.offlineimap.enable = true;
  programs.notmuch.enable = true;
}
