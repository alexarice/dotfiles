{ config, lib, pkgs, ... }:

let
  inherit (config) dots scripts modifier;
in
{
  wayland.windowManager.sway = {
    enable = true;
    extraSessionCommands = ''
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';

    config = {
      bars = [];
      colors = {
        focused = {
          border = "#81c1e4";
          background = "#81c1e4";
          text = "#FFFFFF";
          indicator = "#2e9ef4";
          childBorder = "#81c1e4";
        };
        focusedInactive = {
          border = "#282a36";
          background = "#282a36";
          text = "#999999";
          indicator = "#484e50";
          childBorder = "#282a36";
        };
        unfocused = {
          border = "#282a36";
          background = "#282a36";
          text = "#999999";
          indicator = "#282a36";
          childBorder = "#282a36";
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
        inner = 10;
        outer = -10;
        bottom = -6;
        smartBorders = "on";
      };
      inherit modifier;
      menu = "wldash";
      terminal = "alacritty";
      workspaceAutoBackAndForth = true;
      keybindings = lib.mkOptionDefault {
        "${modifier}+n" = "exec caja";
        "${modifier}+m" = "exec \"GDK_BACKEND=x11 thunderbird\"";
        "${modifier}+b" = lib.mkForce "exec emacsclient -c";
        "${modifier}+c" = "exec firefox";
        "${modifier}+p" = "exec ${scripts}/take_screenshot";
        "${modifier}+Shift+p" = "exec ${scripts}/take_screenshot full";
        "${modifier}+l" = "exec \"swaylock -f -c 000000\"";
        "XF86MonBrightnessUp" = "exec \"brillo -A 1\"";
        "XF86MonBrightnessDown" = "exec \"brillo -U 1\"";
        "XF86AudioLowerVolume" = "exec \"pactl set-sink-volume 0 -5%\"";
        "XF86AudioRaiseVolume" = "exec \"pactl set-sink-volume 0 +5%\"";
        "XF86AudioPlay" = "exec \"playerctl play\"";
        "XF86AudioPause" = "exec \"playerctl pause\"";
        "XF86AudioNext" = "exec \"playerctl next\"";
        "XF86AudioPrev" = "exec \"playerctl previous\"";
        "${modifier}+x" = "exec networkmanager_dmenu";
        "${modifier}+Ctrl+r" = "exec reboot";
        "${modifier}+Ctrl+k" = "exec \"shutdown -h now\"";
        "${modifier}+Ctrl+s" = "exec \"swaylock -f -c 000000 && systemctl suspend\"";
      };
      window = {
        border = 2;
        titlebar = false;
      };

      startup = [
        { command = "dropbox start"; always = true; }
      ];
      input = {
        "2:7:SynPS/2_Synaptics_TouchPad" = {
          natural_scroll = "enabled";
        };
        "1739:0:Synaptics_TM2668-002" = {
          natural_scroll = "enabled";
        };
        "*" = if config.machine == "laptop" then {
          xkb_layout = "gb,gb";
          xkb_variant = "dvorak,";
          xkb_options = "grp:alt_space_toggle,caps:none";
        } else {
          xkb_layout = "gb";
          xkb_options = "caps:none";
        };
      };
      output = if config.machine == "laptop" then {
        "*" = {
          bg = "\"${dots}/background-image.png\" fill";
        };
        "HDMI-A-1" = {
          pos = "0,0";
          res = "1920x1080";
        };
        "HDMI-A-2" = {
          pos = "1920,0";
          res = "1920x1080";
        };
        "eDP-1" = {
          pos = "1120,1080";
          res = "1600x900";
        };
      } else {
        "*" = {
          bg = "\"${dots}/background-image.png\" fill";
        };
        "DP-1" = {
          pos = "0,0";
          res = "1920x1080";
        };
        "HDMI-A-1" = {
          pos = "1920,0";
          res = "1920x1080";
        };
      };
    };
  };
}
