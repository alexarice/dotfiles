{
  description = "Nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    master.url = "github:nixos/nixpkgs";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    home-manager.url = "github:nix-community/home-manager";
    all-agda.url = "github:alexarice/all-agda";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    flake-parts.url = "github:hercules-ci/flake-parts";
    emacs-nix.url = "github:alexarice/emacs-nix";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kmonad.url = "github:kmonad/kmonad?dir=nix";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./desktop.nix
        ./wsl.nix
        ./framework.nix
        ./overlays.nix # Should probably move to per system
      ];
      systems = ["x86_64-linux"];
    };
}
