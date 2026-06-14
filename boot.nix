{
  config,
  pkgs,
  lib,
  ...
}: {
  boot.tmp.useTmpfs = true;

  boot.supportedFilesystems = ["ntfs"];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader = {
    # Use the systemd-boot EFI boot loader.
    systemd-boot = {
      enable = true;
      consoleMode = "auto";
    };
    efi.canTouchEfiVariables = true;
  };
}
