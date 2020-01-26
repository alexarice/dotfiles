{ config, pkgs, ... }:
let
  inherit (import /home/alex/dotfiles/overlays.nix) fishOverlay;
  USBID = "a4ede8f0-01";
in
{
  imports =
    [
      /home/alex/dotfiles/home.nix
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/cachix.nix
    ];

    nixpkgs = {
      config = {
        allowUnfree = true;
        oraclejdk.accept_license = true;
      };
    };

    boot.initrd.kernelModules = [ "usbcore" "usb_storage" "vfat" ];

    boot.initrd.luks.devices = {
      cryptlvm = {
        device = "/dev/sda2";
        # keyFile = "/dev/disk/by-partuuid/${USBID}";
        # fallbackToPassword = true;
        # keyFileSize = 4096;
        allowDiscards = true;
        preLVM = true;
      };
    };

    boot.supportedFilesystems = [ "ntfs" ];

    security.sudo.enable = true;
    security.sudo.extraConfig = "Defaults pwfeedback";

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.consoleMode = "max";
    boot.loader.efi.canTouchEfiVariables = true;
    # boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "Alex_Nixos"; # Define your hostname.
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
      opengl.extraPackages32 = [ pkgs.pkgsi686Linux.libva ];
      cpu.intel.updateMicrocode = true;
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

      geoclue2.enable = true;

      tlp.enable = true;
      logind.lidSwitch = "ignore";
    };

    services.gvfs.enable = true;
    environment.variables.GIO_EXTRA_MODULES = [
      "${pkgs.gnome3.gvfs}/lib/gio/modules"
    ];

    programs.gnupg.agent.enable = true;
    programs.sway.enable = true;
    programs.dconf.enable = true;
    programs.adb.enable = true;
    services.dbus.packages = [ pkgs.gnome3.dconf ];

    # Enable sound.
    sound.enable = true;

    programs.fish = {
      enable = true;
      loginShellInit = ''
        not set -q DISPLAY && test (tty) = /dev/tty1
        and exec env _JAVA_AWT_WM_NONREPARENTING=1 sway
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
}
