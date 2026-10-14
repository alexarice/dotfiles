{pkgs, ...}: {
  hm = {
    home.packages = with pkgs; [
      # System monitoring
      fastfetch
      htop
      btop

      # File tools
      tree
      file
      unzip
      zip
      p7zip
      unrar
      ncdu
      xdg-utils

      # Utilities
      curl
      jq
      ripgrep
      cloc
      psmisc
      gparted
      pdftk
      imagemagick
      git-extras
      calc
      libnotify
    ];

    programs.nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    home.sessionVariables = {
      EDITOR = "emacsclient -c";
      BROWSER = "firefox";
    };

    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      keymap.mgr.prepend_keymap = [
        {
          on = "c";
          run = "arrow prev";
        }
        {
          on = "t";
          run = "arrow next";
        }
        {
          on = "h";
          run = "leave";
        }
        {
          on = "n";
          run = "enter";
        }
      ];
      shellWrapperName = "y";
      initLua = ''
        require("session"):setup {
         sync_yanked = true,
        }
      '';
    };
  };
}
