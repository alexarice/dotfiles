{
  config,
  lib,
  inputs,
  ...
}: {
  flake.nixosConfigurations.framework = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs.inputs = inputs;
    modules = [
      ./common.nix
      ./users.nix
      ./home.nix
      ./hardware/framework.nix
      ./cachix.nix
      # ./kmonad.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.fps.nixosModules.programs-sqlite
      inputs.nixos-hardware.nixosModules.framework-11th-gen-intel
      ({...}: {
        nixpkgs = {
          inherit (config) overlays;
        };
        boot.initrd.luks.devices = {
          cryptlvm = {
            device = "/dev/nvme0n1p1";
            allowDiscards = true;
            preLVM = true;
          };
        };

        machine = "framework";

        networking.hostName = "Alex_fm"; # Define your hostname.

        hardware = {
          cpu.intel.updateMicrocode = true;
        };

        services = {
          upower.enable = true;
          fprintd.enable = false;
          tlp.enable = true;
          logind.lidSwitch = "ignore";
        };
        system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;

        services.ratbagd.enable = true;
      })
    ];
  };
}
