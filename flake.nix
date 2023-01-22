{
  description = "Nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    master.url = "github:nixos/nixpkgs";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    home-manager.url = "github:nix-community/home-manager";
    nixmacs.url = "github:alexarice/nixmacs";
    all-agda.url = "github:alexarice/all-agda";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, master, nixpkgs-wayland, home-manager, nixmacs, all-agda, emacs-overlay, nixos-wsl, nixos-hardware }:
  let overlays = [
    emacs-overlay.overlay
    (self: super: removeAttrs (nixpkgs-wayland.overlay self super) [ "sway-unwrapped" "wlroots" ])
    all-agda.overlay."x86_64-linux"
    (self: super: {
      nixmacs = nixmacs.nixmacs {
        configurationFile = ./nixmacsConf.nix;
        package = self.pkgs.emacs;
        extraOverrides = self: super: {
          agda2-mode = all-agda.legacyPackages."x86_64-linux".agdaPackages-2_6_2.agda-mode super;
        };
      };
    })
    (self: super: {
      discord = (import master {
        system = "x86_64-linux";
        config.allowUnfree = true;
      }).discord;
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
      framework = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./common.nix
          ./users.nix
          ./home.nix
          ./overlays.nix
          ./hardware/framework.nix
          ./cachix.nix
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.framework
          ({ ... }: {
            nixpkgs.overlays = overlays;
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
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
          })
        ];
      };
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./cachix.nix
          ./overlays.nix
          home-manager.nixosModules.home-manager
          nixos-wsl.nixosModules.wsl
          ({ pkgs, ... }: let
            stateVersion = "22.11";
            in {
            system.stateVersion = stateVersion;
            home-manager.users.nixos = { lib, ... }: {
              imports = [
                ./git.nix
                ./fish.nix
                ./direnv.nix
              ];
              programs.git.signing = lib.mkForce null;
              home.stateVersion = stateVersion;
            };

            users.users.nixos.shell = pkgs.fish;

            wsl = {
              enable = true;
              automountPath = "/mnt";
              defaultUser = "nixos";
              startMenuLaunchers = true;
            };
            nix.package = pkgs.nixVersions.stable;
            nix.extraOptions = ''
              experimental-features = nix-command flakes
            '';
            services.xserver.enable = true;
            services.xserver.layout = "gb";
            services.xserver.xkbVariant = "dvorak";

            # Load fonts
            fonts = {
              fonts = with pkgs; [
                source-code-pro
                powerline-fonts
                symbola
                dejavu_fonts
                emacs-all-the-icons-fonts
                noto-fonts
              ];

              fontconfig = {
                enable = true;
                antialias = true;
                cache32Bit = true;
                defaultFonts = {
                  monospace = [ "Source Code Pro" "DejaVu Sans Mono" ];
                  sansSerif = [  "DejaVu Sans" ];
                  serif = [  "DejaVu Serif" ];
                };
              };
            };

            nixpkgs.overlays = overlays;
            nixpkgs.config = {
              allowUnfree = true;
            };
            environment.systemPackages = with pkgs; [
              git
              (nixmacs.fromConf ./wsl-nixmacs.nix)
	            emacs
              ripgrep
              xorg.setxkbmap
              docker
              # Dictionaries
              aspell
              aspellDicts.en
            ];
          })
        ];
      };
    };
  };
}
