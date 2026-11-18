{
  config,
  lib,
  ...
}:
lib.mkIf (lib.elem config.machine ["desktop" "framework" "wsl"]) {
  hm.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
