{ config, pkgs, ... }:

{
  imports = [
    /home/alex/dotfiles/common.nix
    /etc/nixos/hardware-configuration.nix
    /etc/nixos/cachix.nix
  ];

  config = {
    boot.initrd.luks.devices = {
      cryptlvm = {
        device = "/dev/sda2";
        allowDiscards = true;
        preLVM = true;
      };
    };

    hardware = {
      cpu.intel.updateMicrocode = true;
    };

    services = {
      upower.enable = true;

      tlp.enable = true;
      logind.lidSwitch = "ignore";
    };
  };
}
