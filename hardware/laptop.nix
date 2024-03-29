# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "sd_mod"];
  boot.initrd.kernelModules = ["dm-snapshot"];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1cec557b-0b80-4e8b-a27e-30cee2805d52";
    fsType = "ext4";
    options = [
      "defaults"
      "discard"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C243-4AFB";
    fsType = "vfat";
  };

  swapDevices = [{device = "/dev/disk/by-uuid/ba10799c-58d3-45f1-bf82-f9b4be6f5c6f";}];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
