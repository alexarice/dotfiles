{ config, lib, pkgs, ... }:

with lib;

{
  home-manager.users.alex = {pkgs, lib, ...}:
  {
    imports = [
      ./packages.nix
      ./alacritty.nix
      ./files.nix
      ./git.nix
      ./gtk.nix
      ./direnv.nix
      ./fish.nix
      ./gammastep.nix
      ./systemd.nix
      ./sway.nix
      ./emails.nix
      ./gpg.nix
    ];

    options = {
      dots = mkOption {
        type = types.path;
      };
      scripts = mkOption {
        type = types.path;
      };
      modifier = mkOption {
        type = types.str;
      };
      machine = mkOption {
        type = types.enum [
          "laptop"
          "desktop"
          "rpi"
        ];
      };
    };

    config = {
      _module.args.setEnvironment = config.system.build.setEnvironment;

      nixpkgs.config = {
        allowBroken = true;
        allowUnfree = true;
        allowUnsupportedSystem = true;
        oraclejdk.accept_license = true;
      };

      nixpkgs.overlays = builtins.attrValues (import ./overlays.nix);

      dots = /home/alex/dotfiles;
      scripts = /home/alex/scripts;
      modifier = "Mod4";
      machine = config.machine;
    };
  };
}
