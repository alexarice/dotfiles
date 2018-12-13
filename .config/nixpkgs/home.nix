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
      backgroundColor = "#363636";
      clickableUrl = true;
      cursorBlink = "system";
      cursorColor = "#dcdccc";
      cursorForegroundColor = "#dcdccc";
      cursorShape = "block";
      colorsExtra = ''
        color0 = #3f3f3f
        color1 = #8080ff
        color2 = #00bf00
        color3 = #dfaf8f
        color4 = #506070
        color5 = #dc8cc3
        color6 = #8cd0d3
        color7 = #dcdccc
        color8 = #709080
        color9 = #dca3a3
        color10 = #c3bf9f
        color11 = #f0dfaf
        color12 = #94bff3
        color13 = #ec93d3
        color14 = #93e0e3
        color15 = #ffffff
        '';
      dynamicTitle = true;
      filterUnmatchedUrls = true;
      font = "Source Code Pro 10";
      foregroundColor = "#dcdccc";
      foregroundBoldColor = "#ffffff";
      fullscreen = false;
      highlightColor = "#808080";
      scrollOnOutput = false;
      scrollOnKeystroke = true;
      searchWrap = false;
      urgentOnBell = true;
    };
    zsh = {
      enableAutosuggestions = true;
      history = {
        ignoreDups = true;
      };
    };
  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.adapta-gtk-theme;
      name = "Adapta-Nokta-Eta";
    };
    iconTheme = {
      package = pkgs.gnome3.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
  services = {
    polybar = {
      enable = true;
      config = "${dots}/polybar";
      script = "${scripts}/polybarLaunch";
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
         "${i3mod}+n" = "exec thunar";
         "${i3mod}+m" = "exec thunderbird";
         "${i3mod}+b" = "exec emacs";
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
       ];
       window = {
         border = 1;
         titlebar = true;
       };
    };
  };
}
