{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs;
    if config.machine != "rpi"
    then [
      wldash
      wl-clipboard
      cachix
      pinentry
      binutils
      zoom-us
      rmapi

      # CLI Programs
      neofetch
      tree
      wget
      gnupg
      curl
      psmisc
      gparted
      mkpasswd
      jq
      file
      binutils
      imagemagick
      unzip
      zip
      pdftk
      lgogdownloader
      htop
      gitAndTools.git-extras
      numactl
      piper

      # Things in sway config
      networkmanager_dmenu
      networkmanagerapplet
      dmenu

      # Nix
      nixos-generators
      alejandra
      nixpkgs-review
      nix-info
      nix-index
      direnv

      # GTK
      hicolor-icon-theme

      # Dictionaries
      hunspell
      hunspellDicts.en_GB-ise

      # Wayland
      mako
      grim
      slurp
      waybar
      swaylock

      # Utilities
      blueman
      pavucontrol
      udiskie
      playerctl
      libnotify
      libappindicator
      bitwarden-cli
      xdg-utils

      # Desktop environment
      (mate.caja-with-extensions.override {extensions = [mate.caja-extensions];})
      mate.eom
      glib
      shared-mime-info
      libreoffice

      # LaTeX
      texlive.combined.scheme-full

      # Programming
      (agda-2_6_4.withPackages (p: with p; [ standard-library cubical ]))
      cabal-install
      (haskellPackages.ghcWithPackages (self: [ self.filemanip ]))
      python3
      cargo
      rustc
      gnumake
      gdb
      lldb
      gcc

      # Programs
      firefox-wayland
      chromium
      thunderbird
      vlc
      gimp
      evince
      spotify
      libreoffice
      discord
      zathura
      (zotero.overrideAttrs (attrs: attrs // { meta = (attrs.meta // { knownVulnerabilities = []; }); }))
      ripgrep
      signal-desktop

      # Games
      steam
      sgt-puzzles
      runelite
      lutris
      wine
    ]
    else [
      wldash
      wl-clipboard
      git
      emacs
      nixmacsrpi
      pinentry
      (python37.withPackages (p: [p.discordpy p.gspread p.oauth2client]))
    ];
}
