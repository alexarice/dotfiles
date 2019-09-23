{ pkgs, ... }:

{
  home.packages = (with pkgs.haskellPackages; [
    apply-refact
    hlint
    stylish-haskell
    Agda
  ]) ++ (with pkgs; [

    wldash
    nixmacs

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
    adapta-gtk-theme
    gnome3.adwaita-icon-theme
    arc-icon-theme
    arc-theme
    ant-theme
    ant-dracula-theme
    ant-nebula-theme
    ant-bloody-theme
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
    cabal-install
    cabal2nix
    nodejs
    python3

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

    # Games
    steam
    steamcmd
    sgtpuzzles
    (openmw.overrideAttrs ( attrs: attrs // { patches = [ ./openmw.patch ]; }))
    steam-run-native
  ]);
}
