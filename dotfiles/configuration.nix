# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  boot.plymouth.enable = true;

  boot.initrd.luks.devices = [
    {
      name = "cryptlvm";
      device = "/dev/sda2";
      preLVM = true;
    }
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Alex_Nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
    opengl.driSupport32Bit = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      home-manager
      
      emacs
      firefox
      thunderbird
      bup
      termite
      polybar
      git
      texlive.combined.scheme-full
      ghc
      haskellPackages.Agda
      tree
      wget
      gnupg
      curl
      aspell
      aspellDicts.en
      vlc
      xorg.xbacklight
      psmisc
      gparted
      gimp
      blueman
      pavucontrol
      nodejs
      python
      scrot
      evince
      dropbox
      spotify
      libreoffice
      discord
      j4-dmenu-desktop
      mkpasswd
      dunst
      imagemagick
      redshift

      adapta-gtk-theme
      gnome3.adwaita-icon-theme
    ];
  };

  services.flatpak = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      inconsolata
      terminus_font_ttf
      unifont
      siji
      fira-mono
      ubuntu_font_family
      google-fonts
      source-code-pro
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.nixosManual.showManual = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  #TODO check

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "gb";
    displayManager.auto = {
      enable = true;
      user = "alex";
    };
    desktopManager.xfce = {
      enable = true;
      noDesktop = true;
      thunarPlugins = with pkgs.xfce; [
        thunar-dropbox-plugin
	      thunar-archive-plugin
	      thunar_volman
      ];
    };
    windowManager.default = "i3";
    windowManager.i3.enable = true;
    libinput = {
      enable = true;
      tapping = true;
    };
  };

  programs.zsh.enable = true;
  users = {
    mutableUsers = false;
    users.root = {
      shell = pkgs.zsh;
      hashedPassword = "$6$4dxSa3uVxuwa$2pkshyXLslXxhuZCMZVmrknXsrd4k5DTrJgoL4izv6U/XQJ6iM2asqX.L6chpmEiBlhJC1F1P7Pw/3RZX/VMN0";
    };
    users.alex = {
      shell = pkgs.zsh;
      isNormalUser = true;
      home = "/home/alex";
      extraGroups = ["wheel" "networkmanager" "audio"];
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
