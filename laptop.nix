{
  config,
  lib,
  inputs,
  ...
}: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./common.nix
      ./users.nix
      ./home.nix
      ./hardware/laptop.nix
      ./cachix.nix
      inputs.home-manager.nixosModules.home-manager
      ({config, ...}: {
        nixpkgs = {
          inherit (config) overlays;
        };
        boot.initrd.luks.devices = {
          cryptlvm = {
            device = "/dev/sda2";
            allowDiscards = true;
            preLVM = true;
          };
        };

        machine = "laptop";

        networking.hostName = "Alex_Nixos"; # Define your hostname.

        hardware = {
          cpu.intel.updateMicrocode = true;
        };

        services = {
          upower.enable = true;

          tlp.enable = true;
          logind.lidSwitch = "ignore";
        };
        system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
      })
    ];
  };
}
