{inputs, ...}:
inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs.inputs = inputs;
  modules = [
    ../core
    ../dev
    ../gui
    ../system
    ./hardware.nix
    ({pkgs, ...}: {
      machine = "desktop";
      networking.hostName = "Desktop_Nixos";
    })
  ];
}
