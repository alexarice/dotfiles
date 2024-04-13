{
  trivialBuild,
  agda-input,
}:
trivialBuild rec {
  pname = "catt-mode";
  version = "master";

  src = ./.;

  packageRequires = [
    agda-input
  ];
}
