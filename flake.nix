
{
  description = "Nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    master.url = "github:nixos/nixpkgs";
    nixpkgs-wayland.url = "github:colemickens/nixpkgs-wayland";
    home-manager.url = "github:nix-community/home-manager";
    nixmacs.url = "github:alexarice/nixmacs";
    all-agda.url = "/home/alex/all-agda";
  };

  outputs = { self, nixpkgs, master, nixpkgs-wayland, home-manager, nixmacs, all-agda }:
  let overlays = [
    nixpkgs-wayland.overlay
    all-agda.overlay
    (self: super: {
      nixmacs = nixmacs.nixmacs {
        configurationFile = ./nixmacsConf.nix;
        package = self.pkgs.emacs;
        extraOverrides = self: super: {
          agda2-mode = all-agda.legacyPackages."x86_64-linux".agdaPackages-master.agda-mode super;
        };
      };
    })
  ];
  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./common.nix
          ./users.nix
          ./home.nix
          ./overlays.nix
          ./hardware/desktop.nix
          ./cachix.nix
          home-manager.nixosModules.home-manager
          ({ ... }: {
            nixpkgs.overlays = overlays;
            machine = "desktop";
            networking.hostName = "Desktop_Nixos";
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
          })
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./common.nix
          ./users.nix
          ./home.nix
          ./overlays.nix
          ./hardware/laptop.nix
          ./cachix.nix
          home-manager.nixosModules.home-manager
          ({ ... }: {
            nixpkgs.overlays = overlays;
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
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
          })
        ];
      };
    };
  };
}
