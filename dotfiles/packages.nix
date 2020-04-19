{ pkgs, ... }:

let
  std-lib = import ./pkgs/std-lib;
in
{
  home.packages = with pkgs; [

    wldash
    nixmacs
    wl-clipboard
    cachix
    catt
    pinentry
    binutils
    pythonPackages.binwalk
    zoom-us

    # CLI Programs
    neofetch
    tree
    wget
    gnupg
    curl
    psmisc
    gparted
    mkpasswd
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

    # Things in sway config
    j4-dmenu-desktop
    bemenu
    dropbox-cli
    networkmanager_dmenu
    networkmanagerapplet
    dmenu

    # Nix
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
    xlibs.xeyes
    veracrypt
    libnotify
    libappindicator
    bitwarden-cli
    xdg_utils

    # Desktop environment
    (mate.caja-with-extensions.override { extensions = [ mate.caja-extensions mate.caja-dropbox ]; })
    mate.eom
    glib

    # LaTeX
    texlive.combined.scheme-full

    # Programming
    (haskellPackages.ghcWithHoogle
    (haskellPackages: with haskellPackages; [
      lens
      arrows
      process
      containers
      parsec
      multimap
      quickcheck-with-counterexamples
      cassava
      diagrams
      ieee
      filemanip
    ]))
    # ((callPackage (import ./pkgs/agda-packages-devel.nix) { inherit (haskellPackages) Agda; }).withPackages (p: [ p.standard-library ]))
    ((import ../nixpkgs { }).agda.withPackages (p: [ (p.callPackage std-lib {
      inherit  (haskellPackages) ghcWithPackages;
    }) ]))
    cabal-install
    cabal2nix
    python3
    android-studio

    # Programs
    emacs
    firefox
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

    # Games
    steam
    sgtpuzzles
    steam-run-native
    wine
    winetricks
  ];
}
