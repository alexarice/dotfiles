{
  lib,
  inputs,
  ...
}: {
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs.inputs = inputs;
    modules = [
      ./core
      ./dev
      ./gui
      ./system
      ./hardware/desktop.nix
      ({pkgs, ...}: {
        machine = "desktop";
        networking.hostName = "Desktop_Nixos";
      })
    ];
  };
}
