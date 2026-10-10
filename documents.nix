{
  pkgs,
  inputs,
  ...
}: {
  hm.home.packages = with pkgs; [
    # Typesetting
    texliveFull
    typst
    tinymist
    typstyle

    # Office
    onlyoffice-desktopeditors

    # Spell checking
    hunspell
    hunspellDicts.en_GB-ise

    # PDF viewers
    zathura
    evince

    # Reference management
    (inputs.nixpkgs-zotero.legacyPackages."x86_64-linux".zotero)
  ];
}
