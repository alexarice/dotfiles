{ config, lib, pkgs, ... }:
let
  dots = "/home/alex/dotfiles";
  scripts = "/home/alex/scripts";
  modifier = "Mod4";
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  antOverlay = self: super: {
    inherit (import /home/alex/nixpkgs2 { })
    ant-theme ant-dracula-theme ant-nebula-theme ant-bloody-theme;
  };
  waylandOverlay = import (builtins.fetchTarball url);
  emacsOverlay = import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    });
  inherit (waylandOverlay {} pkgs) redshift-wayland wldash dot-desktop;
in
{
  imports = [ /home/alex/home-manager/nixos ];

  home-manager.users.alex = {pkgs, lib, ...}:
  {
    nixpkgs.config.allowBroken = true;
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [ antOverlay emacsOverlay ];

    home.packages = (with pkgs.haskellPackages; [
      apply-refact
      hlint
      stylish-haskell
      Agda
    ]) ++ (with pkgs; [

      wldash
      (pkgs.callPackage (/home/alex/nixmacs) { configurationFile = /home/alex/dotfiles/nixmacsConf.nix; package = pkgs.emacsGit; })
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
      nixpkgs-fmt
      nix-review
      nix-info
      direnv

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
      #texlive.combined.scheme-full

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
      #steam
      sgtpuzzles
      #(openmw.overrideAttrs ( attrs: attrs // { patches = [ ./openmw.patch ]; }))
      #steam-run-native
    ]);

    programs = {
      alacritty = {
        enable = true;
        settings = {
          tabspaces = 2;
          font = {
            normal = {
              family = "Source Code Pro for Powerline";
              style = "Regular";
            };
            bold = {
              family = "Source Code Pro for Powerline";
              style = "Bold";
            };
            italic = {
              family = "Source Code Pro for Powerline";
              style = "Italic";
            };
            bold-italic = {
              family = "Source Code Pro for Powerline";
              style = "Bold Italic";
            };
            size = 10;
          };
          colors = {
            primary = {
              background = "#282a36";
              foreground = "#f8f8f2";
            };
            cursor = {
              cursor = "#81c1e4";
            };
            selection = {
              background = "#ccccc7";
            };
            normal = {
              black =   "#000000";
              red =     "#ff5555";
              green =   "#50fa7b";
              yellow =  "#f1fa8c";
              blue =    "#caa9fa";
              magenta = "#ff79c6";
              cyan =    "#8be9fd";
              white =   "#bfbfbf";
            };
            bright = {
              black =   "#575b70";
              red =     "#ff6e67";
              green =   "#5af78e";
              yellow =  "#f4f99d";
              blue =    "#caa9fa";
              magenta = "#ff92d0";
              cyan =    "#9aedfe";
              white =   "#e6e6e6";
            };
          };
          background_opacity = 0.8;
          mouse.url.launcher = "firefox";
        };
      };
      git = {
        enable = true;
        userName = "Alex Rice";
        userEmail = "alexrice999@hotmail.co.uk";
        ignores = ["*~"];
        extraConfig.core.filemode = false;
      };
      sway = {
        enable = true;
        config = {
          bars = [];
          colors = {
            focused = {
              border = "#2A38A8";
              background = "#2A38A8";
              text = "#FFFFFF";
              indicator = "#2e9ef4";
              childBorder = "#333333";
            };
            focusedInactive = {
              border = "#333333";
              background = "#333333";
              text = "#999999";
              indicator = "#484e50";
              childBorder = "#333333";
            };
            unfocused = {
              border = "#333333";
              background = "#333333";
              text = "#999999";
              indicator = "#292d2e";
              childBorder = "#333333";
            };
            urgent = {
              border = "#FF0000";
              background = "#8C5665";
              text = "#FF0000";
              indicator = "#900000";
              childBorder = "#FF0000";
            };
          };
          fonts = [ "Source Code Pro 9" ];
          gaps = {
            inner = 0;
            bottom = 4;
            smartBorders = "on";
          };
          inherit modifier;
          menu = "wldash";
          terminal = "alacritty";
          keybindings = lib.mkOptionDefault {
            "${modifier}+n" = "exec caja";
            "${modifier}+m" = "exec \"GDK_BACKEND=x11 thunderbird\"";
            "${modifier}+b" = lib.mkForce "exec nixmacs";
            "${modifier}+c" = "exec firefox";
            "${modifier}+p" = "exec ${scripts}/take_screenshot";
            "${modifier}+l" = "exec \"swaylock -f -c 000000\"";
            "XF86MonBrightnessUp" = "exec \"brillo -A 1\"";
            "XF86MonBrightnessDown" = "exec \"brillo -U 1\"";
            "XF86AudioLowerVolume" = "exec \"pactl set-sink-volume 0 -5%";
            "XF86AudioRaiseVolume" = "exec \"pactl set-sink-volume 0 +5%\"";
            "${modifier}+x" = "exec networkmanager_dmenu";
            "${modifier}+Ctrl+r" = "exec reboot";
            "${modifier}+Ctrl+k" = "exec \"shutdown -h now\"";
            "${modifier}+Ctrl+s" = "exec \"swaylock -f -c 000000 && systemctl suspend\"";
          };
          window = {
            border = 1;
            titlebar = false;
          };
        };
        extraPackages = with pkgs; [xwayland swaylock swayidle];
        extraConfig = ''
          input "2:7:SynPS/2_Synaptics_TouchPad" {
            natural_scroll enabled
          }

          input "1739:0:Synaptics_TM2668-002" {
            natural_scroll enabled
          }

          input "*" {
            xkb_layout gb
            xkb_variant dvorak
          }

          output HDMI-A-2 pos 0,0 res 1920x1080 bg "~/dotfiles/background-image-2.png" fill

          output eDP-1 pos 0,1080 res 1600x900 bg "~/dotfiles/background-image-2.png" fill
        '';
        systemdIntegration = true;
      };
      termite = {
        enable = false;
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
            exec ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway
          fi
          eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
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
          EDITOR = "nixmacs";
          BROWSER = "firefox";
        };
      };
    };
    services.redshift = {
      enable = true;
      package = redshift-wayland;
      latitude = "51.2092712";
      longitude = "0.2556012999999666";
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
    systemd.user.services = {
      waybar = {
        Unit = {
          Description = pkgs.waybar.meta.description;
          PartOf = [ "graphical-session.target" ];
        };
        Install = {
          WantedBy = [ "sway-session.target" ];
        };
        Service = {
          ExecStart = "${pkgs.waybar}/bin/waybar";
          RestartSec = 3;
          Restart = "always";
        };
      };
      mako = {
        Unit = {
          Description = pkgs.mako.meta.description;
          PartOf = [ "graphical-session.target" ];
        };
        Install = {
          WantedBy = [ "sway-session.target" ];
        };
        Service = {
          ExecStart = "${pkgs.mako}/bin/mako --default-timeout 10000";
          RestartSec = 3;
          Restart = "always";
        };
      };
      dropbox = {
        Unit = {
          Description = pkgs.dropbox.meta.description;
          PartOf = [ "local-fs.target" "network.target" ];
        };
        Install = {
          WantedBy = [ "multi-user.target" ];
        };
        Service = {
          ExecStart = "/home/alex/.dropbox-dist/dropboxd";
          RestartSec = 3;
          Restart = "on-failure";
          User="alex";
        };
      };
      udiskie = {
        Unit = {
          Description = pkgs.udiskie.meta.description;
          PartOf = [ "graphical-session.target" ];
        };
        Install = {
          WantedBy = [ "sway-session.target" ];
        };
        Service = {
          ExecStart = "${pkgs.udiskie}/bin/udiskie";
          RestartSec = 3;
          Restart = "always";
        };
      };
      redshift.Install.WantedBy = lib.mkForce [ "sway-session.target" ];
    };
  };
}
