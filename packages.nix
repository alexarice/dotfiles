{pkgs, ...}: {
  hm.home.packages = with pkgs; [
    # CLI Programs
    fastfetch
    tree
    curl
    psmisc
    gparted
    jq
    file
    imagemagick
    unzip
    zip
    pdftk
    htop
    git-extras
    calc
    cloc

    # Dictionaries
    hunspell
    hunspellDicts.en_GB-ise

    # Utilities
    libnotify
    libappindicator
    bitwarden-cli
    xdg-utils
    ncdu
    graphviz

    # Desktop environment
    (caja-with-extensions.override {extensions = [caja-extensions];})
    nnn
    qview
    glib
    shared-mime-info

    # LaTeX
    texlive.combined.scheme-full
    typst
    tinymist
    typstyle

    # Programming
    (agda.withPackages (p: with p; [standard-library]))
    elan
    cabal-install
    python314
    cargo
    rustc
    rustfmt
    clippy
    gnumake
    gdb
    lldb
    lld
    cmake
    ccache
    clang
    ninja

    # Programs
    firefox
    chromium
    thunderbird
    vlc
    gimp
    spotify
    libreoffice
    discord
    slack
    zathura
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
