{
  pkgs,
  inputs,
  ...
}: let
  # Minted workaround: https://github.com/NixOS/nixpkgs/issues/542483
  # Delete this overlay once nixpkgs ships minted >= 3.8.0
  minted-overlay = final: prev: let
    version = "3.8.0";
    src = prev.fetchFromGitHub {
      owner = "gpoore";
      repo = "minted";
      rev = "631f7e8e93f37d4f6e7767ff45692d53e7c7360d";
      hash = "sha256-xUWScWRR62ikRxxz/YEauWLirvhsQPCcyE1O6cpWZRw=";
    };
    minted = prev.texlive.pkgs.minted;
    container = name: container: script:
      prev.runCommand "minted-${version}${name}" {
        inherit (container) meta;
        passthru = container.passthru // {inherit version;};
      }
      script;
  in {
    texlive =
      prev.texlive
      // {
        pkgs =
          prev.texlive.pkgs
          // {
            minted =
              minted
              // {
                tex = container "-tex" minted.tex ''
                  install -Dm444 -t "$out"/tex/latex/minted \
                    ${src}/latex/minted/minted.sty \
                    ${src}/latex/minted/minted1.sty \
                    ${src}/latex/minted/minted2.sty
                '';
                out = container "" minted.out ''
                  mkdir -p "$out"/bin
                  ln -s ${prev.lib.getExe prev.latexminted} "$out"/bin/latexminted
                '';
              };
          };
      };
  };
in {
  overlays = [minted-overlay];

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
