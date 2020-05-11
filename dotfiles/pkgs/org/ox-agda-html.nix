{ stdenv, trivialBuild, s }:

trivialBuild rec {
  pname = "org-agda-export";
  version = "master";

  src = ../../../org-agda-export;
}
