{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  options.overlays = lib.mkOption {
    type = lib.types.listOf lib.types.unspecified;
    default = [];
  };

  config = {
    nix = {
      settings = {
        trusted-users = [
          "root"
          "alex"
        ];

        auto-optimise-store = true;
        warn-dirty = false;
      };

      registry.nixpkgs.flake = inputs.nixpkgs;

      extraOptions = ''
        keep-outputs = true
        keep-derivations = true
        experimental-features = nix-command flakes
      '';
    };

    nixpkgs = {
      inherit (config) overlays;
      config = {
        allowUnfree = true;
      };
    };

    programs.command-not-found.enable = false;

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib
        zstd
        stdenv.cc.cc.lib
      ];
    };

    services.envfs.enable = lib.mkIf (config.machine != "container") true;

    hm.nixpkgs = lib.mkIf (config.machine != "container") {
      config = {
        allowBroken = true;
        allowUnfree = true;
        allowUnsupportedSystem = true;
        oraclejdk.accept_license = true;
      };
      inherit (config) overlays;
    };

    hm.home.packages = lib.mkIf (config.machine != "container") (with pkgs; [
      cachix
      nix-du
      nixos-generators
      alejandra
      nixpkgs-review
      nix-info
      nix-index
    ]);
  };
}
