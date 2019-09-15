{ config, pkgs, ... }:
let
  inherit (import /home/alex/dotfiles/overlays.nix) fishOverlay brilloOverlay;
  USBID = "a4ede8f0-01";
in
{
  imports =
    [
      /home/alex/dotfiles/home.nix
      /etc/nixos/hardware-configuration.nix
    ];

    nixpkgs = {
      overlays = [ brilloOverlay fishOverlay ];
      config = {
        allowUnfree = true;
      };
    };


    boot.initrd.kernelModules = [ "usbcore" "usb_storage" "vfat" ];

    boot.initrd.luks.devices = [
      {
        name = "cryptlvm";
        device = "/dev/sda2";
        keyFile = "/dev/disk/by-partuuid/${USBID}";
        fallbackToPassword = true;
        allowDiscards = true;
        preLVM = false;
        keyFileSize = 4096;
      }
    ];

    boot.supportedFilesystems = [ "ntfs" ];

    security.sudo.enable = true;
    security.sudo.extraConfig = "Defaults pwfeedback";


    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.consoleMode = "max";
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "Alex_Nixos"; # Define your hostname.
    networking.networkmanager.enable = true;

    # Select internationalisation properties.
    i18n = {
      consoleFont = "Lat2-Terminus16";
      consoleKeyMap = "uk";
      defaultLocale = "en_GB.UTF-8";
    };

    hardware = {
      pulseaudio = {
        enable = true;
        support32Bit = true;
        package = pkgs.pulseaudioFull;
      };
      bluetooth.enable = true;
      opengl.enable = true;
      opengl.driSupport32Bit = true;
      cpu.intel.updateMicrocode = true;
    };

    # Set your time zone.
    time.timeZone = "Europe/London";

    nix.extraOptions = "keep-outputs = true";

    # System packages
    environment = {
      systemPackages = with pkgs; [
        git
        bup
        brillo
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
        nerdfonts
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

      upower.enable = true;

      mingetty.autologinUser = "alex";

      udev.packages = [ pkgs.brillo ];

      tlp.enable = true;
      logind.lidSwitch = "ignore";
    };

    services.gvfs.enable = true;
    environment.variables.GIO_EXTRA_MODULES = [
      "${pkgs.gnome3.gvfs}/lib/gio/modules"
    ];

    programs.dconf.enable = true;
    services.dbus.packages = [ pkgs.gnome3.dconf ];

    # Enable sound.
    sound.enable = true;

    programs.fish = {
      enable = true;
      loginShellInit = ''
        not set -q DISPLAY && test (tty) = /dev/tty1
        and exec ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway
      '';
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
        extraGroups = ["wheel" "networkmanager" "video" "audio"];
        uid = 1000;
        hashedPassword = "$6$lY0U5C4WoOcmj.6$YLKJMkQVUJDbItcyHV7wZuvmzpvmOcPR9dgHWJYzUHBB7bSevyC4Vqpqm2IxoVqqhpz.KY7aQJnQI2HaSDsL1.";
      };
    };
    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "unstable"; # Did you read the comment?
}
