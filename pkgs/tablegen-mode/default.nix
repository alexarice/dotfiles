{
  llvm_18,
  melpaBuild,
}:
melpaBuild {
  pname = "tablegen-mode";
  version = "0-unstable-2024-07-15";

  inherit (llvm_18) src;

  files = ''("llvm/utils/emacs/tablegen-mode.el")'';
}
