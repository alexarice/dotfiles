{ stdenv, trivialBuild, fetchFromGitHub }:

trivialBuild rec {
  pname = "use-package";
  version = "2.4.1";

  src = fetchFromGitHub {
    owner = "jwiegley";
    repo = "use-package";
    rev = version;
    sha256 = "088kl3bml0rs5bkfymgzr15ram9qvy66h1kaisrbkynh0yxvf8g9";
  };
}
