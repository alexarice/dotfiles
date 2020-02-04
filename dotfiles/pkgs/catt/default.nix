{ stdenv, fetchFromGitHub, ocamlPackages }:

ocamlPackages.buildDune2Package {
  pname = "catt";
  version = "master";

  src = fetchFromGitHub {
    repo = "catt.io";
    owner = "ericfinster";
    rev = "e8de81fa70b0d7dbe874c20b8bea1f095558ee20";
    sha256 = "0nxzky13dwaag850grxbwaqh2jrarxirw7fqbv6n89xc95cb99gq";
  };

  buildInputs = with ocamlPackages; [
    menhir
  ];
}
