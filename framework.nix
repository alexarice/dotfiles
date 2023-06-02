{
  config,
  lib,
  inputs,
  ...
}: {
  flake.nixosConfigurations.framework = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./common.nix
      ./users.nix
      ./home.nix
      ./hardware/framework.nix
      ./cachix.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.nixos-hardware.nixosModules.framework
      ({...}: {
        nixpkgs = {
          inherit (config) overlays;
        };
        _module.args.inputs = inputs;
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

          tlp.enable = true;
          logind.lidSwitch = "ignore";
        };
        system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;

        services.ratbagd.enable = true;
      })
    ];
  };
}
