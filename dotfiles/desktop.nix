{ pkgs, ... }:

let
  inherit (import /home/alex/dotfiles/overlays.nix) amdvlkOverlay;
in
{
  imports = [
    ./common.nix
    ../../../etc/nixos/hardware-configuration.nix
    ../../../etc/nixos/cachix.nix
  ];

  machine = "desktop";

  networking.hostName = "Desktop_Nixos";

  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.variables.VK_ICD_FILENAMES = "${pkgs.amdvlk}/share/vulkan/icd.d/amd_icd64.json";
}
