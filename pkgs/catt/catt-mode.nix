{
  melpaBuild,
  agda2-mode,
}:
melpaBuild {
  pname = "catt-mode";
  version = "0-unstable-2024-07-15";

  src = ./.;

  packageRequires = [
    agda2-mode
  ];
}
