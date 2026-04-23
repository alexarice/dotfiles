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
    ./home.nix
    ./nix.nix
    ./git.nix
    ./direnv.nix
    ./fish.nix
    ./cachix.nix
    ./emacs.nix
  ];
}
