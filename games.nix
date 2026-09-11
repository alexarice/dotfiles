{pkgs, inputs, ...}: {
  programs.steam = {
    enable = true;
  };

  hm.home.packages = with pkgs; [
    inputs.my-nixpkgs.legacyPackages."x86_64-linux".sgt-puzzles
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
