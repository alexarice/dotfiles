{ config, lib, inputs, ... }:

{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./common.nix
      ./users.nix
      ./home.nix
      ./hardware/desktop.nix
      ./cachix.nix
      inputs.home-manager.nixosModules.home-manager
      ({ ... }: {
        nixpkgs = {
          inherit (config) overlays;
        };
        nix.registry.nixpkgs.flake = inputs.nixpkgs;
        machine = "desktop";
        networking.hostName = "Desktop_Nixos";
        system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
      })
    ];
  };
}
