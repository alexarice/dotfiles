# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  waylandOverlay = (import (builtins.fetchTarball url));
  brilloOverlay = self: super: { brillo = (import /home/alex/nixpkgs { }).brillo; };
  antOverlay = self: super: {
    inherit (import /home/alex/nixpkgs2 { })
    ant-theme ant-dracula-theme ant-nebula-theme ant-bloody-theme;
  };
in
{
  imports =
    [
    /etc/nixos/hardware-configuration.nix
    /etc/nixos/cachix.nix
    ];

  nixpkgs.overlays = [ waylandOverlay brilloOverlay antOverlay ];

  boot.plymouth.enable = true;

  boot.initrd.luks.devices = [
    {
      name = "cryptlvm";
      device = "/dev/sda2";
      preLVM = true;
    }
  ];

  boot.supportedFilesystems = [ "ntfs" ];

  security.sudo.enable = true;
  security.sudo.extraConfig = "Defaults pwfeedback";


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
    opengl.driSupport32Bit = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  nixpkgs.config.allowUnfree = true;
  nix.extraOptions = "keep-outputs = true";

  # List packages installed in system profile. To search, run:
  environment = {
    systemPackages = (with pkgs.haskellPackages; [
      apply-refact
      hlint
      stylish-haskell
    ]) ++ (with pkgs; [
      home-manager

      # Programs
      emacs
      firefox
      chromium
      thunderbird
      vlc
      gimp
      evince
      spotify
      libreoffice
      discord
      steam
      sgtpuzzles
      zathura

      # LaTeX
      texlive.combined.scheme-full

      # Programming
      (haskellPackages.ghcWithHoogle
        (haskellPackages: with haskellPackages; [
          lens
          arrows
          process
          containers
          parsec
          multimap
          ]))
      cabal-install
      nix-prefetch-git
      cabal2nix
      nodejs
      python
      nodePackages.tern

      # CLI Programs
      wine
      git
      bup
      neofetch
      tree
      wget
      gnupg
      curl
      psmisc
      gparted
      mkpasswd
      file
      binutils
      imagemagick
      unzip
      zip
      pdftk

      # Dictionaries
      aspell
      aspellDicts.en

      # Wayland
      mako
      grim
      slurp
      waybar
      redshift-wayland
      brillo

      # Utilities
      blueman
      pavucontrol
      udiskie
      playerctl
      xlibs.xeyes
      veracrypt
      libnotify
      libappindicator

      # Desktop environment
      termite
      mate.caja
      mate.eom
      glib

      # Things in I3 config
      j4-dmenu-desktop
      bemenu
      dropbox

      # GTK
      adapta-gtk-theme
      gnome3.adwaita-icon-theme
      arc-icon-theme
      ant-theme
      ant-dracula-theme
      ant-nebula-theme
      ant-bloody-theme
    ]);
  };

  # Load fonts
  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      inconsolata
      terminus_font_ttf
      siji
      fira-mono
      ubuntu_font_family
      google-fonts
      source-code-pro
      powerline-fonts
      font-awesome
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

    # Start emacs server
    emacs.enable = true;
    emacs.defaultEditor = true;

    mingetty.autologinUser = "alex";

    udev.packages = [ pkgs.brillo ];

    tlp.enable = true;
    logind.extraConfig = "HandleLidSwitch=ignore";
  };

  services.gnome3.gvfs.enable = true;
  environment.variables.GIO_EXTRA_MODULES = [
    "${pkgs.gnome3.gvfs}/lib/gio/modules"
  ];

  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gnome3.dconf ];

  # Enable sound.
  sound.enable = true;

  programs.sway.enable = true;
  programs.sway.extraPackages = with pkgs; [xwayland swaylock swayidle swaybg];

  # Use Zsh
  programs.zsh.enable = true;

  # Set up immutable users
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
