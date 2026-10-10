{
  pkgs,
  inputs,
  ...
}: {
  hm.home.packages = with pkgs; [
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
    qview
    glib
    shared-mime-info

    # LaTeX
    texliveFull
    typst
    tinymist
    typstyle

    # Programming
    (agda.withPackages (p: with p; [standard-library]))
    elan
    cabal-install
    python314
    uv
    cargo
    rustc
    wasm-pack
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
    onlyoffice-desktopeditors
    discord
    slack
    zathura
    evince
    (inputs.nixpkgs-zotero.legacyPackages."x86_64-linux".zotero)
    signal-desktop
    zulip
    inkscape
    blender
  ];
}
