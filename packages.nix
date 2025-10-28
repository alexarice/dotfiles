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
      rmapi
      unetbootin

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
      imagemagick
      unzip
      zip
      pdftk
      lgogdownloader
      htop
      gitAndTools.git-extras
      numactl
      piper
      perf

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
      nix-du
      graphviz

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
      wdisplays
      wlprop

      # Utilities
      blueman
      pavucontrol
      udiskie
      playerctl
      libnotify
      libappindicator
      bitwarden-cli
      xdg-utils
      ncdu
      protonvpn-gui

      # Desktop environment
      (mate.caja-with-extensions.override {extensions = [mate.caja-extensions];})
      nnn
      qview
      glib
      shared-mime-info

      # LaTeX
      texlive.combined.scheme-full
      (callPackage ./pkgs/textidote {})
      typst
      tinymist
      typstyle

      # Programming
      (agda.withPackages (p: with p; [standard-library]))
      cabal-install
      python313
      cargo
      rustc
      rustfmt
      clippy
      gnumake
      gdb
      lldb
      clang

      # Programs
      firefox-wayland
      chromium
      thunderbird
      vlc
      gimp
      spotify
      libreoffice
      vesktop
      slack
      zathura
      kdePackages.okular
      evince
      zotero
      ripgrep
      signal-desktop
      zulip
      inkscape

      # Games
      # sgt-puzzles
      lutris
      wine
      runelite
      runescape
      osu-lazer-bin
      prismlauncher
      ckan
      heroic

      # 3D print
      blender
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
