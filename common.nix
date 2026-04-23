{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = [
    ./mako.nix
    ./core.nix
    ./packages.nix
    ./alacritty.nix
    ./files.nix
    ./gammastep.nix
    ./gpg.nix
    ./gtk.nix
    ./helix.nix
    ./systemd.nix
    ./sway.nix
    ./kdeconnect.nix
    ./users.nix
    ./games.nix
    ./boot.nix
    ./fonts.nix
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

    i18n = {
      defaultLocale = "en_GB.UTF-8";
    };

    hardware = {
      bluetooth = {
        enable = true;
      };
      graphics = {
        enable = true;
      };
      brillo.enable = true;
    };

    # Set your time zone.
    time.timeZone = "Europe/London";

    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        wireplumber.extraConfig."11-bluetooth-policy" = {
          "wireplumber.settings" = {
            "bluetooth.autoswitch-to-headset-profile" = false;
          };
        };
      };

      dbus.enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      wlr.enable = true;
    };
  };
}
