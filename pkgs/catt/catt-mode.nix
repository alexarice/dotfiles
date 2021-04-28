{ stdenv, trivialBuild, catt }:

trivialBuild rec {
  pname = "catt-mode";
  version = "master";

  src = ./.;
}
