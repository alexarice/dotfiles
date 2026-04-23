{pkgs, ...}: {
  hm.home.packages = with pkgs; [
    cachix

    # CLI Programs
    fastfetch
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
    htop
    git-extras
    perf
    calc
    cloc

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
    adwaita-icon-theme

    # Dictionaries
    hunspell
    hunspellDicts.en_GB-ise

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
    proton-vpn

    # Desktop environment
    (caja-with-extensions.override {extensions = [caja-extensions];})
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
    elan
    cabal-install
    python314
    python314Packages.jupyter-core
    cargo
    rustc
    rustfmt
    clippy
    gnumake
    gdb
    lldb
    clang

    # Programs
    firefox
    chromium
    thunderbird
    vlc
    gimp
    spotify
    libreoffice
    onlyoffice-documentserver
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

    # 3D print
    blender
  ];
}
