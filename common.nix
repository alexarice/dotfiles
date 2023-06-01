{ config, pkgs, lib, ... }:

with lib;

{
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
        trusted-users = [ "root" "alex" ];

        auto-optimise-store = true;
      };

      extraOptions = ''
        keep-outputs = true
        keep-derivations = true
        experimental-features = nix-command flakes
      '';
    };

    nixpkgs.config = {
      allowUnfree = true;
    };

    services.xserver.videoDrivers = mkIf (config.machine == "desktop") [ "amdgpu" ];

    services.fwupd.enable = true;
    boot.tmp.useTmpfs = true;

    environment.variables.VK_ICD_FILENAMES = mkIf (config.machine == "desktop") "${pkgs.amdvlk}/share/vulkan/icd.d/amd_icd64.json";

    boot.supportedFilesystems = [ "ntfs" ];

    security.sudo.enable = true;
    security.sudo.extraConfig = "Defaults pwfeedback";
    programs.sway = {
      enable = true;
      extraSessionCommands = ''
        export _JAVA_AWT_WM_NONREPARENTING=1
        export XDG_CURRENT_DESKTOP=sway
        export XDG_SESSION_TYPE=wayland
        systemctl --user import-environment
      '';
      extraPackages = [];
    };

    programs.nm-applet = {
      enable = true;
      indicator = true;
    };

    services.ratbagd.enable = mkIf (config.machine == "desktop" || config.machine == "framework") true;

    boot.loader = if config.machine == "rpi" then {
       grub.enable = false;
       generic-extlinux-compatible.enable = true;
    } else {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "max";
      efi.canTouchEfiVariables = true;
    };
    # boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.firewall = {
        enable = true;
        allowedTCPPortRanges = [
            { from = 1714; to = 1764; } # KDE Connect
        ];
        allowedUDPPortRanges = [
            { from = 1714; to = 1764; } # KDE Connect
        ];
    };

    networking.networkmanager = {
      enable = true;
    # wifi.backend = "iwd";
    };

    # Select internationalisation properties.
    # console = {
    #   font = "lat2-Terminus16";
    #   keyMap = "uk";
    # };

    i18n = {
      defaultLocale = "en_GB.UTF-8";
    };

    hardware = {
      # pulseaudio = {
      #   enable = true;
      #   support32Bit = mkIf (config.machine != "rpi") true;
      #   package = pkgs.pulseaudioFull;
      # };
      bluetooth = {
        enable = true;
      };
      opengl = {
        enable = true;
        driSupport32Bit = mkIf (config.machine != "rpi") true;
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
        gnome.adwaita-icon-theme
      ];
      homeBinInPath = true;
    };

    # Load fonts
    fonts = {
      fonts = with pkgs; [
        source-code-pro
        powerline-fonts
        symbola
        dejavu_fonts
        emacs-all-the-icons-fonts
        (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
      ] ++ optional (config.machine != "rpi") noto-fonts;
      enableDefaultFonts = mkIf (config.machine == "rpi") false;

      fontconfig = {
        enable = true;
        antialias = true;
        cache32Bit = true;
        defaultFonts = {
          monospace = [ "Fira Code Nerd Font Mono" "DejaVu Sans Mono" ];
          sansSerif = [  "DejaVu Sans" ];
          serif = [  "DejaVu Serif" ];
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
      };

      dbus.enable = true;
      # xserver = {
      #   enable = true;
      #   desktopManager.plasma5.enable = true;
      #   displayManager.startx.enable = true;
      # };
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      wlr.enable = true;
    };

    services.gvfs.enable = mkIf (config.machine != "rpi") true;

    programs.dconf.enable = mkIf (config.machine != "rpi") true;
    programs.adb.enable = mkIf (config.machine != "rpi") true;

    # Enable sound.
    sound.enable = true;

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

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "18.09"; # Did you read the comment?
  };
}
