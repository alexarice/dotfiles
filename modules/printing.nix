{
  config,
  lib,
  ...
}:
lib.mkIf (lib.elem config.machine ["desktop" "framework"]) {
  services.printing = {
    enable = true;
    cups-pdf.enable = true;
  };
}
