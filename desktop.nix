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
      ./linux.nix
      ./hardware/desktop.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.fps.nixosModules.programs-sqlite
      ({pkgs, ...}: {
        time.hardwareClockInLocalTime = true;
        machine = "desktop";
        networking.hostName = "Desktop_Nixos";
        system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
        services.ratbagd.enable = true;
      })
    ];
  };
}
