{ stdenv, fetchFromGitHub, ocamlPackages }:

ocamlPackages.buildDune2Package {
  pname = "catt";
  version = "master";

  src = fetchFromGitHub {
    repo = "catt.io";
    owner = "ericfinster";
    rev = "5dfa3d8c9bef3f572a165f5083635db368011c68";
    sha256 = "082v3pcpv2kzs0iqa668g94wynkkj1rqxxmfabd5m9ciiz0fgds8";
  };

  buildInputs = with ocamlPackages; [
    menhir
  ];
}
