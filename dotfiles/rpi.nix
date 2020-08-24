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
	    gspread = (import ../nixpkgs { }).python37Packages.gspread;
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

    networking.networkmanager.enable = false;
    networking.hostName = "rpi-nixos";

    services.sshd.enable = true;
    services.mingetty.autologinUser = "alex";
    
    environment.systemPackages = with pkgs; [
      git
      emacs
      (python37.withPackages (p: [ p.discordpy p.gspread p.oauth2client ]))
    ];

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = null;
    };

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
