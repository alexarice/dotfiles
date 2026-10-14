{
  imports = [
    ./alacritty.nix
    ./apps.nix
    ./boot.nix
    ./cachix.nix
    ./core.nix
    ./direnv.nix
    ./documents.nix
    ./emacs
    ./files.nix
    ./fonts.nix
    ./games.nix
    ./git.nix
    ./gpg.nix
    ./gtk.nix
    ./helix.nix
    ./home.nix
    ./kdeconnect.nix
    ./networking.nix
    ./nix.nix
    ./printing.nix
    ./programming.nix
    ./sound.nix
    ./terminal.nix
    ./udiskie.nix
    ./users.nix
    ./virtualisation.nix
    ./wayland.nix
    ./minted.nix
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
