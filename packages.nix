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
      aspell
      aspellDicts.en

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

      # LaTeX
      texlive.combined.scheme-full

      # Programming
      (agda-2_6_4.withPackages (p: with p; [standard-library]))
      cabal-install
      python3
      cargo
      rustc
      gnumake

      # Programs
      firefox-wayland
      chromium
      thunderbird
      vlc
      gimp
      evince
      spotify
      # libreoffice
      discord
      zathura
      ripgrep
      signal-desktop
      zotero

      # Games
      steam
      sgt-puzzles
      runelite
      bottles
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
