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
      zoom-us
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
      linuxPackages_latest.perf

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

      # Desktop environment
      (mate.caja-with-extensions.override {extensions = [mate.caja-extensions];})
      mate.eom
      glib
      shared-mime-info
      libreoffice

      # LaTeX
      texlive.combined.scheme-full
      texpresso
      (callPackage ./pkgs/textidote {})

      # Programming
      (agda.withPackages (p: with p; [standard-library cubical]))
      cabal-install
      (haskellPackages.ghcWithPackages (self: [self.filemanip]))
      python3
      cargo
      rustc
      rustfmt
      clippy
      gnumake
      gdb
      lldb
      gurobi
      ninja
      cmake
      clang
      mold

      # Programs
      firefox-wayland
      chromium
      thunderbird
      vlc
      gimp
      evince
      spotify
      libreoffice
      vesktop
      (zathuraPkgs.override {useMupdf = false;}).zathuraWrapper
      (zotero.overrideAttrs (attrs: attrs // {meta = attrs.meta // {knownVulnerabilities = [];};}))
      ripgrep
      signal-desktop
      zulip
      zulip-term
      inkscape
      vscode

      # Games
      sgt-puzzles
      lutris
      wine
      runelite
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
