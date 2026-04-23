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
  ];

  config = {
    services.printing = {
      enable = true;
      cups-pdf.enable = true;
    };

    security.sudo.enable = true;
    security.sudo.extraConfig = "Defaults pwfeedback";
    programs.sway = {
      enable = true;
      extraSessionCommands = ''
        export _JAVA_AWT_WM_NONREPARENTING=1
        export XDG_CURRENT_DESKTOP=sway
        export XDG_SESSION_TYPE=wayland
        export MOZ_ENABLE_WAYLAND=1
        systemctl --user import-environment
      '';
      extraPackages = [];
      wrapperFeatures.gtk = true;
    };

    programs.nm-applet = {
      enable = true;
      indicator = true;
    };

    boot.tmp.useTmpfs = true;

    boot.supportedFilesystems = ["ntfs"];

    boot.kernelPackages = pkgs.linuxPackages_latest;

    boot.loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        extraEntries = mkIf (config.machine == "desktop") {
          "windows.conf" = ''
            title Windows
            efi /EFI/Microsoft/Boot/bootmgfw.efi
            sort-key b_windows
          '';
        };
        extraInstallCommands = ''
          echo "auto-entries no" >> /boot/loader/loader.conf
        '';
      };
      efi.canTouchEfiVariables = true;
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

    # Load fonts
    fonts = {
      packages = with pkgs; [
        nerd-fonts.hack
        noto-fonts-color-emoji
        noto-fonts-cjk-sans
        roboto
        font-awesome
        freefont_ttf
        symbola
        dejavu_fonts
        fira
        source-code-pro
        source-sans
      ];
      enableDefaultPackages = false;

      fontconfig = {
        enable = true;
        antialias = true;
        cache32Bit = true;
        defaultFonts = {
          monospace = ["Hack Nerd Font"];
          sansSerif = ["DejaVu Sans"];
          serif = ["DejaVu Serif"];
        };
      };
    };

    services = {
      geoclue2 = {
        enable = true;
        appConfig.gammastep = {
          isSystem = false;
          isAllowed = true;
        };
      };

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

    programs.nix-ld = {
      enable = true;
    };
  };
}
