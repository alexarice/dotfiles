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
      ./linux.nix
      ./hardware/framework.nix
      inputs.nixos-hardware.nixosModules.framework-13-7040-amd
      ({...}: {
        boot.initrd.luks.devices = {
          cryptlvm = {
            device = "/dev/nvme0n1p1";
            allowDiscards = true;
            preLVM = true;
          };
        };

        machine = "framework";

        networking.hostName = "Alex_fm"; # Define your hostname.

        services = {
          fwupd.enable = true;
          upower.enable = true;
          logind.settings.Login.HandleLidSwitch = "ignore";
        };
        system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
      })
    ];
  };
}
