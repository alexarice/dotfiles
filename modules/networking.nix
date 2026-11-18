{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf (lib.elem config.machine ["desktop" "framework"]) {
  services.timesyncd.enable = true;

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-l2tp
    ];
  };

  hm.home.packages = with pkgs; [
    proton-vpn
  ];
}
