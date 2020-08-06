{ config, pkgs, lib, ... }:

with lib;

let
  inherit (import /home/alex/dotfiles/overlays.nix) waylandOverlay pipewireNoBT;
in
{
  options = {
    machine = mkOption {
      type = types.enum [
        "laptop"
        "desktop"
      ];
    };
  };

  imports =
    [
      ./home.nix
    ];

  config = {
    nixpkgs.overlays = [
      waylandOverlay
      pipewireNoBT
    ];

    nixpkgs.config = {
      allowUnfree = true;
    };

    boot.supportedFilesystems = [ "ntfs" ];

    security.sudo.enable = true;
    security.sudo.extraConfig = "Defaults pwfeedback";
    programs.sway = {
      enable = true;
      extraSessionCommands = ''
        export _JAVA_AWT_WM_NONREPARENTING=1
        export XDG_CURRENT_DESKTOP=sway
        export XDG_SESSION_TYPE=wayland
      '';
    };


    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.consoleMode = "max";
    boot.loader.efi.canTouchEfiVariables = true;
    # boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.networkmanager = {
    enable = true;
    # wifi.backend = "iwd";
    };

    # Select internationalisation properties.
    console = {
      font = "lat2-Terminus16";
      keyMap = "uk";
    };

    i18n = {
      defaultLocale = "en_GB.UTF-8";
    };

    hardware = {
      pulseaudio = {
        enable = true;
        support32Bit = true;
        extraModules = [ pkgs.pulseaudio-modules-bt ];
        package = pkgs.pulseaudioFull;
      };
      bluetooth = {
        enable = true;
        package = pkgs.bluezFull;
      };
      opengl.enable = true;
      opengl.driSupport32Bit = true;
      brillo.enable = true;
    };

    # Set your time zone.
    time.timeZone = "Europe/London";

    nix = {
      extraOptions = "keep-outputs = true";
      autoOptimiseStore = true;
    };

    # System packages
    environment = {
      systemPackages = with pkgs; [
        git
        bup
        xboxdrv
      ];
    };

    # Load fonts
    fonts = {
      fonts = with pkgs; [
        source-code-pro
        powerline-fonts
        symbola
        dejavu_fonts
        emacs-all-the-icons-fonts
        noto-fonts
        # nerdfonts
      ];

      fontconfig = {
        enable = true;
        antialias = true;
        cache32Bit = true;
        defaultFonts = {
          monospace = [ "Source Code Pro" "DejaVu Sans Mono" ];
          sansSerif = [  "DejaVu Sans" ];
          serif = [  "DejaVu Serif" ];
        };
      };
    };

    services = {
      # Save manual
      nixosManual.showManual = true;

      mingetty.autologinUser = "alex";

      geoclue2.enable = true;

      pipewire.enable = true;

      xserver = {
        enable = true;
        desktopManager.plasma5.enable = true;
        displayManager.startx.enable = true;
      };
    };

    xdg.portal = {
      enable = true;
      # gtkUsePortal = true;
      extraPortals = with pkgs; [
        # xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };

    services.gvfs.enable = true;

    programs.dconf.enable = true;
    programs.adb.enable = true;

    # Enable sound.
    sound.enable = true;

    programs.fish = {
      enable = true;
      # loginShellInit = ''
      #   if not set -q SWAYSTARTED
      #     if not set -q DISPLAY && test (tty) = /dev/tty1
      #       set -g SWAYSTARTED 1
      #       exec sway
      #     end
      #   end
      # '';
    };

    # Set up immutable users
    users = {
      mutableUsers = false;
      users.root = {
        shell = pkgs.fish;
        hashedPassword = "$6$4dxSa3uVxuwa$2pkshyXLslXxhuZCMZVmrknXsrd4k5DTrJgoL4izv6U/XQJ6iM2asqX.L6chpmEiBlhJC1F1P7Pw/3RZX/VMN0";
      };
      users.alex = {
        shell = pkgs.fish;
        isNormalUser = true;
        home = "/home/alex";
        extraGroups = ["wheel" "networkmanager" "video" "audio" "adbusers"];
        uid = 1000;
        hashedPassword = "$6$lY0U5C4WoOcmj.6$YLKJMkQVUJDbItcyHV7wZuvmzpvmOcPR9dgHWJYzUHBB7bSevyC4Vqpqm2IxoVqqhpz.KY7aQJnQI2HaSDsL1.";
      };
    };

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "18.09"; # Did you read the comment?
  };
}
