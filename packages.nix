{ pkgs, config, ... }:

{
  home.packages = with pkgs; if config.machine != "rpi" then [

    wldash
    nixmacs
    wl-clipboard
    cachix
    pinentry
    binutils
    manix
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
    pamixer
    lgogdownloader
    fzf
    htop
    iftop
    gitAndTools.git-extras
    numactl
    ocamlPackages.cpdf
    piper

    # Things in sway config
    dropbox-cli
    networkmanager_dmenu
    networkmanagerapplet
    dmenu

    # Nix
    nixos-generators
    nixpkgs-fmt
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
    xorg.xeyes
    libnotify
    libappindicator
    bitwarden-cli
    xdg-utils

    # Desktop environment
    (mate.caja-with-extensions.override { extensions = [ mate.caja-extensions mate.caja-dropbox ]; })
    mate.eom
    glib
    shared-mime-info

    # LaTeX
    texlive.combined.scheme-full

    # Programming
    (haskellPackages.ghcWithHoogle
    (haskellPackages: with haskellPackages; [
      lens
      containers
      parsec
      ieee
      filemanip
    ]))
    (agda-2_6_3.withPackages (p: with p; [ standard-library cubical ]))
    # cabal-bin
    cabal-install
    # cabal2nix
    python3
    coqPackages_8_12.coq
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
    libreoffice
    discord
    mumble
    zathura
    mu
    pijul
    ripgrep
    signal-desktop
    zotero

    # Games
    steam
    sgtpuzzles
    runelite
    # steam-run-native
    # wine
    # winetricks
  ] else [
    wldash
    wl-clipboard
    git
    emacs
    nixmacsrpi
    pinentry
    (python37.withPackages (p: [ p.discordpy p.gspread p.oauth2client ]))
  ];
}
