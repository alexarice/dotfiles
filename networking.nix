{pkgs, ...}: {
  programs.nm-applet = {
    enable = true;
    indicator = true;
  };

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
