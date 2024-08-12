{
  llvmPackages_18,
  melpaBuild,
}:
melpaBuild {
  pname = "mlir-mode";
  version = "0-unstable-2024-07-15";

  inherit (llvmPackages_18.mlir) src;

  files = ''("mlir/utils/emacs/mlir-mode.el")'';
}
