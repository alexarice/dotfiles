{
  lib,
  pkgs,
  ...
}:
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
  config = {
    environment.systemPackages = [pkgs.git];
    system.stateVersion = "18.09";
  };
  imports = [
    ./cachix.nix
    ./direnv.nix
    ./emacs.nix
    ./fish.nix
    ./git.nix
    ./home.nix
    ./nix.nix
  ];
}
