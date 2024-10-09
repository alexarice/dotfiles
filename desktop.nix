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
      inputs.fps.nixosModules.programs-sqlite
      ({pkgs, ...}: {
        nixpkgs = {
          inherit (config) overlays;
        };
        nix.registry.nixpkgs.flake = inputs.nixpkgs;
        time.hardwareClockInLocalTime = true;
        machine = "desktop";
        networking.hostName = "Desktop_Nixos";
        system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
        boot.initrd.kernelModules = ["amdgpu"];
        hardware.graphics = {
          extraPackages = [pkgs.amdvlk];
          extraPackages32 = [pkgs.driversi686Linux.amdvlk];
        };
        services.ratbagd.enable = true;
        virtualisation.libvirtd.enable = true;
        programs.virt-manager.enable = true;
        environment.systemPackages = with pkgs; [
          qemu
          quickemu
        ];
      })
    ];
  };
}
