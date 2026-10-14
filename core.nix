{
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; {
  options = {
    machine = mkOption {
      type = types.enum [
        "framework"
        "desktop"
        "wsl"
        "pi-container"
      ];
    };
  };
  config = {
    programs.fish.enable = true;

    environment.systemPackages = [pkgs.git];
    system = {
      configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
      stateVersion = "26.11";
    };
  };
}
