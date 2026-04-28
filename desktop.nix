{
  lib,
  inputs,
  ...
}: {
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs.inputs = inputs;
    modules = [
      ./linux.nix
      ./hardware/desktop.nix
      ({pkgs, ...}: {
        machine = "desktop";
        networking.hostName = "Desktop_Nixos";
      })
    ];
  };
}
