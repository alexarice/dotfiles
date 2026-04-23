{pkgs, ...}: {
  programs.steam = {
    enable = true;
  };

  hm.home.packages = with pkgs; [
    sgt-puzzles
    lutris
    wine
    (bolt-launcher.override {enableRS3 = true;})
    osu-lazer-bin
    prismlauncher
    ckan
    heroic
    lgogdownloader
  ];
}
