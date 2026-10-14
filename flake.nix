{
  description = "Nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Zotero doesn't build on current nixpkgs (pinned 2026-09-28)
    # See: https://github.com/NixOS/nixpkgs/issues/568692
    nixpkgs-zotero.url = "github:nixos/nixpkgs/7a0f122f5090cf4c2ade2a13a0e229d4e19ba71f";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    all-agda.url = "github:alexarice/all-agda";
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    flake-parts.url = "github:hercules-ci/flake-parts";
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    make-shell.url = "github:nicknovitski/make-shell";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./desktop.nix
        ./wsl.nix
        ./framework.nix
        ./shell.nix
      ];
      systems = ["x86_64-linux"];
    };
}
