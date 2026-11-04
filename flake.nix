{
  description = "Nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    opencode.url = "github:anomalyco/opencode";
    eca.url = "github:editor-code-assistant/eca";
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
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # TODO: Check if onlyoffice fix from PR #582158 (merged Nov 2, 2026, commit acff9c0) has reached nixos-unstable.
    # If yes, remove this pin and use upstream nixpkgs directly.
    my-nixpkgs = {
      url = "github:alexarice/nixpkgs/alexarice/onlyoffice";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations = {
      desktop = import ./desktop {inherit inputs;};
      wsl = import ./wsl {inherit inputs;};
      framework = import ./framework {inherit inputs;};
    };

    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = with nixpkgs.legacyPackages.x86_64-linux; [
        prek
        alejandra
      ];
    };
  };
}
