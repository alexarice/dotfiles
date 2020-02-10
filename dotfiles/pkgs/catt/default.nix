{ stdenv, fetchFromGitHub, ocamlPackages }:

ocamlPackages.buildDune2Package {
  pname = "catt";
  version = "master";

  src = ../../../university/catt/catt.io;

  buildInputs = with ocamlPackages; [
    menhir
  ];
}
