{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs-channels/nixpkgs-unstable";
    emacs.url = "github:nix-community/emacs-overlay";
    master.url = "github:nixos/nixpkgs";
    nixpkgs-wayland.url = "github:colemickens/nixpkgs-wayland";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, emacs, master, nixpkgs-wayland, home-manager }: {
    nixosModules.common = {
      imports = [ ./common.nix ];
      modules = [
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
