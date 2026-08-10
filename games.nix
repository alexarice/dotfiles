{pkgs, ...}: {
  programs.steam = {
    enable = true;
  };

  hm.home.packages = with pkgs; [
    sgt-puzzles
    wine
    bolt-launcher
    osu-lazer-bin
    prismlauncher
    gamescope
    gamemode
    ckan
    heroic
    lgogdownloader
    mangohud
  ];
}
