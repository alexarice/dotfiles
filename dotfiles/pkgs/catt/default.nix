{ stdenv, fetchFromGitHub, ocamlPackages }:

ocamlPackages.buildDunePackage {
  pname = "catt";
  version = "master";

  useDune2 = true;

  src = ../../../university/catt/catt.io;

  buildInputs = with ocamlPackages; [
    menhir
    git
  ];
}
