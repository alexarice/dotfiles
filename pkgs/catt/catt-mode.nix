{
  trivialBuild,
  agda2-mode,
}:
trivialBuild rec {
  pname = "catt-mode";
  version = "master";

  src = ./.;

  packageRequires = [
    agda2-mode
  ];
}
