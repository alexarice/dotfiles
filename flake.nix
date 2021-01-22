{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs-channels/nixpkgs-unstable";
    master.url = "github:nixos/nixpkgs";
    nixpkgs-wayland.url = "github:colemickens/nixpkgs-wayland";
    home-manager.url = "github:nix-community/home-manager";
    nixmacs.url = "/home/alex/nixmacs";
  };

  outputs = { self, nixpkgs, master, nixpkgs-wayland, home-manager, nixmacs }: {
    nixosModules.common = {
      imports = [
        ./common.nix
        ./users.nix
        home-manager.nixosModules.home-manager
        ({ ... }: {
          nixpkgs.overlays = [
            nixpkgs-wayland.overlay
            (self: super: {
              nixmacs = nixmacs.nixmacs {
                configurationFile = ./nixmacsConf.nix;
                package = self.pkgs.emacs;
                extraOverrides = self: super: {
                  use-package = self.callPackage ./pkgs/use-package { };
                };
              };
            })
          ];
        })
      ];
    };
  };

}
