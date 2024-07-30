{
  lib,
  stdenv,
  fetchurl,
  jre,
  makeWrapper,
}:
stdenv.mkDerivation rec {
  pname = "textidote";
  version = "0.8.3";

  src = fetchurl {
    url = "https://github.com/sylvainhalle/textidote/releases/download/v${version}/${pname}.jar";
    hash = "sha256-BIYswDrVqNEB+J9TwB0Fop+AC8qvPo53KGU7iupC7tk=";
  };

  nativeBuildInputs = [makeWrapper];
  buildInputs = [jre];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share
    cp $src $out/share/${pname}.jar
    makeWrapper ${jre}/bin/java $out/bin/${pname} --add-flags "-jar $out/share/${pname}.jar"
  '';
}
