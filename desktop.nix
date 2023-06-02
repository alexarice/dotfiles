{
  config,
  lib,
  inputs,
  ...
}: {
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
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
        _module.args.inputs = inputs;
        nix.registry.nixpkgs.flake = inputs.nixpkgs;
        machine = "desktop";
        networking.hostName = "Desktop_Nixos";
        system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
        services.xserver.videoDrivers = ["amdgpu"];
        environment.variables.VK_ICD_FILENAMES = "${pkgs.amdvlk}/share/vulkan/icd.d/amd_icd64.json";

        services.ratbagd.enable = true;
      })
    ];
  };
}
