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
      ];
    };
  };
  config = {
    environment.systemPackages = [pkgs.git];
    system = {
      configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
      stateVersion = "18.09";
    };
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
