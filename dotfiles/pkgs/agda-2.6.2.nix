{ stdenv }:

stdenv.mkDerivation {
  pname = "Agda-dev";
  version = "2.6.2";

  src = ../../.cabal;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    cp -r bin $out
  '';
}
