{pkgs, ...}: {
  hm.home.packages = with pkgs; [
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

    # Nix
    graphviz

    # Dictionaries
    hunspell
    hunspellDicts.en_GB-ise

    # Utilities
    udiskie
    libnotify
    libappindicator
    bitwarden-cli
    xdg-utils
    ncdu

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
    clang

    # Programs
    firefox
    chromium
    thunderbird
    vlc
    gimp
    spotify
    libreoffice
    vesktop
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
