{
  trivialBuild,
}:
trivialBuild rec {
  pname = "catt-mode";
  version = "master";

  src = ./.;
}
