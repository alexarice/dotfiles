{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf (lib.elem config.machine ["desktop" "framework"]) {
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  virtualisation.containers.enable = true;

  environment.systemPackages = with pkgs; [
    qemu
    quickemu
  ];

  security.sudo.extraRules = [
    {
      users = ["alex"];
      commands = [
        {
          command = "/run/current-system/sw/bin/nixos-container";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}
