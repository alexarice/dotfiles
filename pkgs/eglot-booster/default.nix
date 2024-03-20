{
  trivialBuild,
  fetchFromGitHub,
}:
trivialBuild rec {
  pname = "eglot-booster";
  version = "master";

  src = fetchFromGitHub {
    owner = "jdtsmith";
    repo = "eglot-booster";
    rev = "caee55ee5285659964d0b9fe4101e28de09701ca";
    sha256 = "sha256-KMZi4ARe5t+kxD0Wt74Yi9vkQY7STDyvbqn3WuE2iQE=";
  };
}
