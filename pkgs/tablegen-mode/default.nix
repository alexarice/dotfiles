{
  llvmPackages_22,
  melpaBuild,
}:
melpaBuild {
  pname = "tablegen-mode";
  version = "0-unstable-2024-07-15";

  inherit (llvmPackages_22.llvm) src;

  files = ''("llvm/utils/emacs/tablegen-mode.el")'';
}
