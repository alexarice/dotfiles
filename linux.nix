{
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
    ./networking.nix
    ./packages.nix
    ./printing.nix
    ./sound.nix
    ./systemd.nix
    ./users.nix
    ./virtualisation.nix
    ./wayland.nix
  ];

  config = {
    i18n.defaultLocale = "en_GB.UTF-8";
    time.timeZone = "Europe/London";

    services.dbus.enable = true;
  };
}
