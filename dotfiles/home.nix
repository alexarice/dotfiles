{ config, lib, pkgs, ... }:

with lib;

{
  imports = [ /home/alex/home-manager/nixos ];

  home-manager.users.alex = {pkgs, lib, ...}:
  {
    imports = [
      ./packages.nix
      ./overlays.nix
      ./alacritty.nix
      ./files.nix
      ./git.nix
      ./direnv.nix
      ./fish.nix
      ./redshift.nix
      ./systemd.nix
      ./sway.nix
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
    };

    config = {
      nixpkgs.config = {
        allowBroken = true;
        allowUnfree = true;
      };

      dots = /home/alex/dotfiles;
      scripts = /home/alex/scripts;
      modifier = "Mod4";
    };
  };
}
