
{ config, pkgs, lib, ... }:

{
  imports = [
    ./users.nix
  ];

  config = {
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
      (self: super: {
        nixmacs = let
	  src = builtins.fetchTarball { url = "https://github.com/alexarice/nixmacs/archive/master.tar.gz"; };
	in self.pkgs.callPackage src {
	  configurationFile = /home/alex/dotfiles/nixmacs-conf-rpi.nix;
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

    services.sshd.enable = true;
    services.mingetty.autologinUser = "alex";

    environment.systemPackages = with pkgs; [
      git
      emacs
      nixmacs
      (python37.withPackages (p: [ p.discordpy p.gspread p.oauth2client ]))
    ];

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = null;
    };

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
