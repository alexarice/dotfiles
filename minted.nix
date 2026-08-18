# https://github.com/NixOS/nixpkgs/issues/542483
# Workaround for a broken `minted` in nixpkgs.
#
# The TeX Live snapshot in nixpkgs (2026-03-01) predates minted 3.8.0
# (2026-03-04) and still ships 3.7.0 together with a bundled `latexminted`
# 0.6.0 that does not run. Two independent replacements are needed:
#
#   - the run container: minted.sty from the upstream 3.8.0 release, which
#     requires `latexminted` >= 0.7.0;
#   - the bin container: `pkgs.latexminted` (0.7.1), which works.
#
# The LaTeX package and the Python executable are versioned separately, hence
# the two unrelated version numbers.
#
# Delete this file once nixpkgs ships minted >= 3.8.0.
let
  overlay = final: prev: let
    version = "3.8.0";

    # Byte-identical to the CTAN 3.8.0 release, but pinned and already unpacked
    # (CTAN only ships minted.dtx, which would have to be run through docstrip).
    src = prev.fetchFromGitHub {
      owner = "gpoore";
      repo = "minted";
      rev = "631f7e8e93f37d4f6e7767ff45692d53e7c7360d"; # "[latex] minted v3.8.0"
      hash = "sha256-xUWScWRR62ikRxxz/YEauWLirvhsQPCcyE1O6cpWZRw=";
    };

    minted = prev.texlive.pkgs.minted;

    # texlive.withPackages reads pname/tlType/tlDeps/... off the containers, so
    # reuse the original metadata instead of reconstructing it.
    container = name: container: script:
      prev.runCommand "minted-${version}${name}" {
        inherit (container) meta;
        passthru =
          container.passthru
          // {
            inherit version;
          };
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

                # A bare symlink is enough: texlive.withPackages resolves and wraps
                # everything under bin/ itself.
                out = container "" minted.out ''
                  mkdir -p "$out"/bin
                  ln -s ${prev.lib.getExe prev.latexminted} "$out"/bin/latexminted
                '';
              };
          };
      };
  };
in {
  overlays = [overlay];
}
