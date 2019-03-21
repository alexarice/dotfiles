# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
waybar = pkgs.callPackage /home/alex/dotfiles/waybar-nix/waybar.nix { };
redshift = pkgs.callPackage /home/alex/dotfiles/redshift-wayland/default.nix {
    inherit (pkgs.python3Packages) python pygobject3 pyxdg wrapPython;
    geoclue = pkgs.geoclue2;
  };
brillo = pkgs.callPackage /home/alex/dotfiles/brillo/default.nix{ };
my-python-packages = python-packages : with python-packages; [ dbus-python ];
my-python3 = pkgs.python3.withPackages my-python-packages;
in
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];
  
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

  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gnome3.dconf ];

  # Set your time zone.
  time.timeZone = "Europe/London";

  nixpkgs.config.allowUnfree = true;
  nix.extraOptions = "keep-outputs = true";

  # List packages installed in system profile. To search, run:
  environment = {
    systemPackages = [waybar redshift brillo]
    ++ (with pkgs.haskellPackages; [
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

      # LXDE
      gpicview
      lxtask
      lxappearance
      pcmanfm
      lxmenu-data
      shared_mime_info

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
          ]))
      cabal-install
      nix-prefetch-git
      cabal2nix
      nodejs
      python
      my-python3
      nodePackages.tern

      # CLI Programs
      termite
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

      # Dictionaries
      aspell
      aspellDicts.en

      # Wayland
      mako
      grim
      brightnessctl

      # Utilities
      blueman
      pavucontrol
      dunst
      scrot
      gnome3.gnome-power-manager
      piper

      # Things in I3 config
      j4-dmenu-desktop
      dropbox-cli

      # GTK
      adapta-gtk-theme
      gnome3.adwaita-icon-theme
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

  # Save manual
  services.nixosManual.showManual = true;

  # Start emacs server
  services.emacs.enable = true;
  services.emacs.defaultEditor = true;

  services.upower.enable = true;

  services.ratbagd.enable = true;

  services.mingetty.autologinUser = "alex";

  services.tlp.enable = true;

  # Enable sound.
  sound.enable = true;

  # Disable the X11 windowing system.
  services.xserver.enable = false;

  programs.sway.enable = true;
  programs.sway.extraPackages = with pkgs; [xwayland swaylock swayidle];

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
      extraGroups = ["wheel" "networkmanager" "audio" "video"];
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
