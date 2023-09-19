{
  config,
  lib,
  inputs,
  ...
}: {
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs.inputs = inputs;
    modules = [
      ./common.nix
      ./users.nix
      ./home.nix
      ./hardware/desktop.nix
      ./cachix.nix
      inputs.home-manager.nixosModules.home-manager
      ({pkgs, ...}: {
        nixpkgs = {
          inherit (config) overlays;
        };
        nix.registry.nixpkgs.flake = inputs.nixpkgs;
        time.hardwareClockInLocalTime = true;
        machine = "desktop";
        networking.hostName = "Desktop_Nixos";
        system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
        boot.initrd.kernelModules = [ "amdgpu" ];
        services.ratbagd.enable = true;
      })
    ];
  };
}
