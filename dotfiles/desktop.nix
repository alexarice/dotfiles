{ ... }:

{
  imports = [
    /home/alex/dotfiles/common.nix
    /etc/nixos/hardware-configuration.nix
  ];

  networking.hostName = "Desktop_Nixos";
}
