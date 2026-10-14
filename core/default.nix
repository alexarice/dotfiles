{
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; {
  imports = [
    ./nix.nix
    ./fish.nix
    ./git.nix
    ./home.nix
    ./users.nix
  ];

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

    system = {
      configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
      stateVersion = "26.11";
    };
  };
}
