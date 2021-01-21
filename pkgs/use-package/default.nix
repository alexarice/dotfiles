{ stdenv, trivialBuild, fetchFromGitHub }:

trivialBuild rec {
  pname = "use-package";
  version = "pr-899";

  src = ./use-package;
}
