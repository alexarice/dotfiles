{ pkgs, config, ... }:

let
  cabal-bin = pkgs.callPackage (import ./pkgs/agda-2.6.2.nix) { };
in
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
    swiProlog
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

    # Things in sway config
    dropbox-cli
    networkmanager_dmenu
    networkmanagerapplet
    dmenu

    # Nix
    nixos-generators
    nixpkgs-fmt
    nix-review
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
    xdg_utils

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
    (agda-2_6_2.withPackages (p: [ p.standard-library p.agda-categories p.cubical ]))
    # cabal-bin
    cabal-install
    # cabal2nix
    python3
    coqPackages_8_12.coq
    cargo
    rustc
    gnumake

    # Programs
    emacs
    firefox-bin
    chromium
    thunderbird
    vlc
    gimp
    evince
    spotify
    libreoffice
    discord
    zathura
    mu

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
