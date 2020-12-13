
{ config, pkgs, lib, ... }:

{
  imports = [
    ./common.nix
  ];

  config = {
    machine = "rpi";

    nixpkgs.config.allowUnsupportedSystem = true;

    nixpkgs.overlays = [
      (self: super: {
        python37 = super.python37.override {
	        packageOverrides = pself: psuper: {
	          discordpy = psuper.discordpy.overrideAttrs(attrs: {
              patchPhase = ''
                substituteInPlace "requirements.txt" \
                  --replace "aiohttp>=3.6.0,<3.7.0" "aiohttp>=3.6.0,<3.8.0" \
              '';
            });
	        };
	      };
      })
    ];

    boot.loader.grub.enable = false;
    boot.loader.generic-extlinux-compatible.enable = true;

    boot.kernelPackages = pkgs.linuxPackages_4_19;
    boot.kernelParams = ["cma=32M"];

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/NIXOS_SD";
        fsType = "ext4";
      };
    };
    swapDevices = [ { device = "/swapfile"; size = 1024; } ];

    networking.networkmanager.enable = true;
    networking.hostName = "rpi-nixos";

    hardware.enableRedistributableFirmware = true;

    systemd.user.services.bookbot = {
      enable = true;
      wantedBy = [ "multi-user.target" ];
      description = "BookBot service";
      path = [ (pkgs.python37.withPackages (p: [ p.discordpy p.gspread p.oauth2client ])) ];
      script = "/home/alex/BookBot/discordbot.py";
      serviceConfig = {
        RestartSec = 3;
        Restart = "always";
      };
    };
  };
}
