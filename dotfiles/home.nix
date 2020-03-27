{ config, lib, pkgs, ... }:

with lib;

{
  imports = [ <home-manager/nixos> ];

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
      ./redshift.nix
      ./systemd.nix
      ./sway.nix
      ./emails.nix
      ./lorri.nix
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
    };

    config = {
      _module.args.setEnvironment = config.system.build.setEnvironment;

      nixpkgs.config = {
        allowBroken = true;
        allowUnfree = true;
        oraclejdk.accept_license = true;
      };

      nixpkgs.overlays = builtins.attrValues (import ./overlays.nix);

      dots = /home/alex/dotfiles;
      scripts = /home/alex/scripts;
      modifier = "Mod4";
    };
  };
}
