{lib, ...}:
with lib; {
  options = {
    machine = mkOption {
      type = types.enum [
        "framework"
        "desktop"
        "wsl"
      ];
    };
  };
  config.system.stateVersion = "18.09";
}
