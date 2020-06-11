{ pkgs, ... }:

let
  inherit (import /home/alex/dotfiles/overlays.nix) amdvlkOverlay;
in
{
  imports = [
    /home/alex/dotfiles/common.nix
    /etc/nixos/hardware-configuration.nix
  ];

  machine = "desktop";

  networking.hostName = "Desktop_Nixos";

  nixpkgs.overlays = [ amdvlkOverlay ];

  fileSystems."/home/alex/ssd" = {
    device = "/dev/sda2";
    fsType = "ntfs";
  };

  fileSystems."/home/alex/hdd" = {
    device = "/dev/sdb2";
    fsType = "ntfs";
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.variables.VK_ICD_FILENAMES = "${pkgs.amdvlk}/share/vulkan/icd.d/amd_icd64.json";
}
