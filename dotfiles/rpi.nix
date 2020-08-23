{ config, pkgs, lib, ... }:

{
  imports = [
    ./users.nix
  ];

  config = {
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
    ];

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = null;
    };
  };
}
