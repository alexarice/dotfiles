{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ../../../etc/nixos/hardware-configuration.nix
    ../../../etc/nixos/cachix.nix
  ];

  machine = "desktop";

  networking.hostName = "Desktop_Nixos";
}
