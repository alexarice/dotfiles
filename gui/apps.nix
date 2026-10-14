{pkgs, ...}: {
  hm.home.packages = with pkgs; [
    # Web browsers
    firefox
    chromium

    # Communication
    thunderbird
    discord
    slack
    signal-desktop
    zulip

    # Media
    vlc
    spotify

    # Graphics & design
    gimp
    inkscape
    qview
    blender
    graphviz
  ];
}
