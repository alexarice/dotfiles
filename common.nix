{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; {
  options = {
    machine = mkOption {
      type = types.enum [
        "laptop"
        "framework"
        "desktop"
        "rpi"
      ];
    };
  };

  config = {
    nix = {
      settings = {
        trusted-users = ["root" "alex"];

        auto-optimise-store = true;
      };

      registry.nixpkgs.flake = inputs.nixpkgs;

      extraOptions = ''
        keep-outputs = true
        keep-derivations = true
        experimental-features = nix-command flakes
      '';
    };

    nixpkgs.config = {
      allowUnfree = true;
    };

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

    programs.command-not-found.enable = true;

    programs.nm-applet = {
      enable = true;
      indicator = true;
    };

    boot.tmp.useTmpfs = true;

    boot.supportedFilesystems = ["ntfs"];

    boot.kernelPackages = pkgs.linuxPackages_latest;

    boot.loader =
      if config.machine == "rpi"
      then {
        grub.enable = false;
        generic-extlinux-compatible.enable = true;
      }
      else {
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

    networking.firewall = {
      enable = true;
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
    };

    networking.networkmanager = {
      enable = true;
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

    # System packages
    environment = {
      systemPackages = with pkgs; [
        git
        bup
        adwaita-icon-theme
      ];
    };

    # Load fonts
    fonts = {
      packages = with pkgs;
        [
          nerd-fonts.hack
          noto-fonts-color-emoji
          noto-fonts-cjk-sans
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
      getty.autologinUser = "alex";

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

    # services.gvfs.enable = mkIf (config.machine != "rpi") true;

    # programs.dconf.enable = mkIf (config.machine != "rpi") true;
    programs.adb.enable = mkIf (config.machine != "rpi") true;
    programs.steam = {
      enable = true;
    };

    programs.fish = {
      enable = true;
      loginShellInit = ''
        if not set -q SWAYSTARTED
          if not set -q DISPLAY && test (tty) = /dev/tty1
            set -g SWAYSTARTED 1
            exec sway
          end
        end
      '';
    };

    programs.nix-ld = {
      enable = true;
    };

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "18.09"; # Did you read the comment?
  };
}
