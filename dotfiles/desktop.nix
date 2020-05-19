{ ... }:

{
  imports = [
    /home/alex/dotfiles/common.nix
    /etc/nixos/hardware-configuration.nix
  ];

  machine = "desktop";

  networking.hostName = "Desktop_Nixos";
}
