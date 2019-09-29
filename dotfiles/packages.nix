
{ pkgs, ... }:

{
  home.packages = with pkgs; [

    wldash
    nixmacs
    wl-clipboard

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

    # Things in sway config
    j4-dmenu-desktop
    bemenu
    dropbox-cli
    networkmanager_dmenu
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
    ]))
    haskellPackages.Agda
    cabal-install
    cabal2nix
    nodejs
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
    steamcmd
    sgtpuzzles
    (openmw.overrideAttrs ( attrs: attrs // { patches = [ ./openmw.patch ]; }))
    steam-run-native
  ];
}
