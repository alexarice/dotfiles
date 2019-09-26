{ config, ... }:

{
  accounts.email.accounts = {
    hotmail = rec {
      primary = true;
      address = "alexrice999@hotmail.co.uk";
      userName = address;
      realName = "Alex Rice";
      passwordCommand = "${config.scripts}/bw-get.fish login.live.com";
      mbsync.enable = true;
      imap = {
        host = "imap-mail.outlook.com";
        tls.enable = true;
      };
      notmuch.enable = true;
    };

    university = rec {
      address = "AXR1014@bham.ac.uk";
      userName = "AXR1014";
      realName = "Alex Rice";
      passwordCommand = "${config.scripts}/bw-get.fish my.bham";
      mbsync = {
        enable = true;
        extraConfig.account.AuthMechs = "Plain";
      };
      imap = {
        host = "mail.bham.ac.uk";
        tls.enable = true;
      };
      notmuch.enable = true;
    };
  };

  programs.mbsync.enable = true;
  programs.notmuch.enable = true;
}
