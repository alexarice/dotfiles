{ config, lib, pkgs, ... }:
let
  dots = "/home/alex/dotfiles";
  scripts = "/home/alex/scripts";
  i3mod = "Mod4";
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  antOverlay = self: super: {
    inherit (import /home/alex/nixpkgs2 { })
    ant-theme ant-dracula-theme ant-nebula-theme ant-bloody-theme;
  };
  waylandOverlay = (import (builtins.fetchTarball url));
  redshift-wayland = (waylandOverlay {} pkgs).redshift-wayland;
in
{
  imports = [ /home/alex/home-manager/nixos ];

  home-manager.users.alex = {pkgs, lib, ...}:
  {
    nixpkgs.config.allowBroken = true;
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [ antOverlay ];

    home.packages = (with pkgs.haskellPackages; [
      apply-refact
      hlint
      stylish-haskell
      Agda
    ]) ++ (with pkgs; [
      # CLI Programs
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
      pamixer
      lgogdownloader

      # Things in sway config
      j4-dmenu-desktop
      bemenu
      dropbox-cli
      networkmanager_dmenu
      dmenu

      # Nix
      nix-review
      nix-info

      # GTK
      adapta-gtk-theme
      gnome3.adwaita-icon-theme
      arc-icon-theme
      arc-theme
      ant-theme
      ant-dracula-theme
      ant-nebula-theme
      ant-bloody-theme
      hicolor-icon-theme

      # Dictionaries
      aspell
      aspellDicts.en

      # Wayland
      mako
      grim
      slurp
      waybar
      redshift-wayland

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
      (mate.caja-with-extensions.override { extensions = [ mate.caja-extensions mate.caja-dropbox ]; })
      mate.eom
      glib

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
      cabal2nix
      nodejs
      python
      nodePackages.tern
      cscope

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
      zathura

      # Games
      steam
      sgtpuzzles
      openmw
      steam-run-native
    ]);

    programs = {
      spacemacs = {
        enable = true;
        configFile = "${dots}/spacemacs";
      };
      git = {
        enable = true;
        userName = "Alex Rice";
        userEmail = "alexrice999@hotmail.co.uk";
        ignores = ["*~"];
        extraConfig = ''
          [core]
          filemode = false
        '';
      };
      termite = {
        enable = true;
        allowBold = true;
        audibleBell = false;
        clickableUrl = true;
        dynamicTitle = true;
        filterUnmatchedUrls = true;
        fullscreen = false;
        scrollOnOutput = false;
        scrollOnKeystroke = true;
        scrollbackLines = 10000;
        searchWrap = false;
        urgentOnBell = true;
        font = "Source Code Pro for Powerline 10";
        cursorBlink = "system";
        cursorColor = "#81c1e4";
        cursorForegroundColor = "#81c1e4";
        cursorShape = "block";
        backgroundColor = "rgba(40,42,54,0.8)";
        foregroundColor = "#f8f8f2";
        foregroundBoldColor = "#f8f8f2";
        highlightColor = "#ccccc7";
        colorsExtra = ''
          color0 = #000000
          color1 = #ff5555
          color2 = #50fa7b
          color3 = #f1fa8c
          color4 = #bd93f9
          color5 = #ff79c6
          color6 = #8be9fd
          color7 = #bbbbbb
          color8 = #555555
          color9 = #ff5555
          color10 = #50fa7b
          color11 = #f1fa8c
          color12 = #bd93f9
          color13 = #ff79c6
          color14 = #8be9fd
          color15 = #ffffff
        '';
      };
      zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        history = {
          ignoreDups = true;
        };
        initExtra = ''
          export DEFAULT_USER=\"alex\"
          prompt_context(){}
          if [[ -z $DISPLAY ]] && [[ $(tty) =
          /dev/tty1 ]]; then
          exec sway
          fi
        '';
        oh-my-zsh = {
          enable = true;
          plugins = [
            "git"
            "sudo"
            "fasd"
            "scala"
            "cabal"
            "extract"
            "systemd"
            "web-search"
          ];
          theme = "agnoster";
        };
        sessionVariables = {
          BROWSER = "firefox";
        };
      };
    };
    gtk = {
      enable = false;
      theme = {
        package = pkgs.adapta-gtk-theme;
        name = "Adapta-Nokto-Eta";
      };
      iconTheme = {
        package = pkgs.gnome3.adwaita-icon-theme;
        name = "Adwaita";
      };
      font = {
        package = pkgs.source-code-pro;
        name = "Source Code Pro 10";
      };
      gtk3.extraConfig = {
        gtk-cursor-theme-size=0;
        gtk-toolbar-style="GTK_TOOLBAR_BOTH";
        gtk-toolbar-icon-size="GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-button-images=1;
        gtk-menu-images=1;
        gtk-enable-event-sounds=1;
        gtk-enable-input-feedback-sounds=1;
        gtk-xft-antialias=1;
        gtk-xft-hinting=1;
        gtk-xft-hintstyle="hintslight";
        gtk-xft-rgba="rgb";
      };
    };
    home.file.".ghc/ghci.conf".source = "${dots}/ghci.conf";
    home.file.".config/waybar/config".source = "${dots}/waybar";
    home.file.".config/waybar/style.css".source = "${dots}/waybar.css";
    home.file.".config/sway/config".source = "${dots}/sway";

  };
}
