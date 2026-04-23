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
      extraEntries = lib.mkIf (config.machine == "desktop") {
        "windows.conf" = ''
          title Windows
          efi /EFI/Microsoft/Boot/bootmgfw.efi
          sort-key b_windows
        '';
      };
      extraInstallCommands = ''
        echo "auto-entries no" >> /boot/loader/loader.conf
      '';
    };
    efi.canTouchEfiVariables = true;
  };
}
