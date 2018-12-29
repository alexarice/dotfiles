{pkgs, lib, ...}:

let
  dots = "/home/alex/dotfiles";
  scripts = "/home/alex/scripts";
  i3mod = "Mod4";
in
{
  programs = {
    git = {
      enable = true;
      userName = "Alex Rice";
      userEmail = "alexrice999@hotmail.co.uk";
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
      searchWrap = false;
      urgentOnBell = true;
      font = "Source Code Pro for Powerline 10";
      cursorBlink = "system";
      cursorColor = "#81c1e4";
      cursorForegroundColor = "#81c1e4";
      cursorShape = "block";
      backgroundColor = "#282a36";
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
      history = {
        ignoreDups = true;
      };
      initExtra = ''
                export DEFAULT_USER=\"alex\"
                prompt_context(){}
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
    };
  };
  gtk = {
    enable = true;
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
  services = {
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
    };
    polybar = {
      enable = true;
      package = pkgs.polybar.override {
              i3Support = true;
              pulseSupport = true;
              };
      config = "${dots}/polybar";
      script = "${scripts}/polybarLaunch";
    };
    dunst = {
      enable = true;
      iconTheme.package = pkgs.gnome3.adwaita-icon-theme;
      iconTheme.name = "Adwaita";
      iconTheme.size = "32x32";
    };
    compton = {
      enable = true;
      inactiveOpacity = "1";
    };
  };
  home.file.".spacemacs".source = "${dots}/spacemacs";
  xsession.windowManager.i3 = {
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
      modifier = i3mod;
      keybindings = lib.mkOptionDefault {
        "${i3mod}+Shift+a" = "exec \"setxkbmap -layout gb\"";
        "${i3mod}+Shift+d" = "exec \"setxkbmap -layout gb -variant dvorak\"";
        "${i3mod}+Shift+Left" = "move left";
        "${i3mod}+Shift+Right" = "move right";
        "${i3mod}+Shift+Up" = "move up";
        "${i3mod}+Shift+Down" = "move down";
         "${i3mod}+n" = "exec pcmanfm";
         "${i3mod}+m" = "exec thunderbird";
         "${i3mod}+b" = "exec emacsclient --create-frame";
         "${i3mod}+Return" = "exec termite";
         "${i3mod}+c" = "exec firefox";
         "${i3mod}+Shift+q" = "kill";
         "${i3mod}+p" = "exec ${scripts}/take_screenshot";
         "${i3mod}+o" = "exec \"i3lock -f\"";
         "XF86MonBrightnessUp" = "exec \"xbacklight -inc 5\"";
         "XF86MonBrightnessDown" = "exec \"xbacklight -dec 5\"";
         "XF86AudioLowerVolume" = "exec \"pactl set-sink-volume 0 -5% && pkill -RTMIN+11 i3blocks\"";
         "XF86AudioRaiseVolume" = "exec \"pactl set-sink-volume 0 +5% && pkill -RTMIN+11 i3blocks\"";
         "${i3mod}+d" = "exec --no-startup-id j4-dmenu-desktop";
         "${i3mod}+Ctrl+r" = "exec reboot";
         "${i3mod}+Ctrl+k" = "exec \"shutdown -h now\"";
         "${i3mod}+Ctrl+s" = "exec \"i3lock -f && systemctl suspend\"";
       };
       startup = [
         { command = "systemctl --user restart polybar"; always = true; notification = false;}
         { command = "redshift -l 51.2092712:0.2556012999999666"; always = false; notification = false;}
         { command = "blueman-applet"; always = false; notification = false;}
         { command = "nm-applet"; always = false; notification = false;}
         { command = "xset -dpms"; always = false; notification = false;}
         { command = "xset s off"; always = false; notification = false;}
         { command = "dropbox start"; always = false; notification = false;}
       ];
       window = {
         border = 1;
         titlebar = true;
       };
    };
  };
}
