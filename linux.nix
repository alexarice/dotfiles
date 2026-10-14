{
  imports = [
    ./alacritty.nix
    ./apps.nix
    ./boot.nix
    ./core
    ./dev
    ./fonts.nix
    ./games.nix
    ./gtk.nix
    ./kdeconnect.nix
    ./networking.nix
    ./printing.nix
    ./sound.nix
    ./udiskie.nix
    ./udiskie.nix
    ./virtualisation.nix
    ./wayland.nix
  ];

  config = {
    i18n.defaultLocale = "en_GB.UTF-8";
    console.useXkbConfig = true;
    time.timeZone = "Europe/London";

    services.dbus.enable = true;
    services.fstrim.enable = true;
    services.timesyncd.enable = true;
  };
}
