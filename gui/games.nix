{pkgs, ...}: {
  programs.steam = {
    enable = true;
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
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
    openmw
  ];
}
