{
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = [
    ./alacritty.nix
    ./boot.nix
    ./core.nix
    ./files.nix
    ./fonts.nix
    ./games.nix
    ./gpg.nix
    ./gtk.nix
    ./helix.nix
    ./kdeconnect.nix
    ./packages.nix
    ./sound.nix
    ./systemd.nix
    ./users.nix
    ./virtualisation.nix
    ./wayland.nix
  ];

  config = {
    services.printing = {
      enable = true;
      cups-pdf.enable = true;
    };

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

    i18n.defaultLocale = "en_GB.UTF-8";
    time.timeZone = "Europe/London";

    services.dbus.enable = true;
  };
}
