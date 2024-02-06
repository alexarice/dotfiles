{
  config,
  lib,
  ...
}: let
  inherit (config) dots scripts modifier;
in {
  wayland.windowManager.sway = {
    enable = true;
    package = null;

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
      fonts = {
        names = ["SauceCodePro Nerd Font Mono 10"];
      };
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
        "${modifier}+m" = "exec thunderbird";
        "${modifier}+b" = lib.mkForce "exec emacsclient -c";
        "${modifier}+h" = lib.mkForce "splith";
        "${modifier}+tab" = "workspace back_and_forth";
        "${modifier}+c" = "exec firefox";
        "${modifier}+p" = "exec ${scripts + "/take_screenshot"}";
        "${modifier}+Shift+p" = "exec ${scripts + "/take_screenshot"} full";
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
        "${modifier}+Shift+s" = "exec grim -g \"$(slurp -d)\" - | wl-copy -t image/png";
        "${modifier}+Ctrl+Left" = "move workspace to output left";
        "${modifier}+Ctrl+Right" = "move workspace to output right";
        "${modifier}+Ctrl+Up" = "move workspace to output up";
        "${modifier}+Ctrl+Down" = "move workspace to output down";
      };
      window = {
        border = 2;
        titlebar = false;
      };
      input = {
        "2:7:SynPS/2_Synaptics_TouchPad" = {
          natural_scroll = "enabled";
        };
        "2362:628:PIXA3854:00_093A:0274_Touchpad" = {
          natural_scroll = "enabled";
        };
        "1739:0:Synaptics_TM2668-002" = {
          natural_scroll = "enabled";
        };
        "*:Logiteck_G900" = {
          accel_profile = "flat";
        };
        "*" =
          if config.machine == "laptop" || config.machine == "framework"
          then {
            xkb_layout = "gb,gb";
            xkb_variant = "dvorak,";
            xkb_options = "grp:alt_space_toggle,caps:menu";
          }
          else {
            xkb_layout = "gb";
            xkb_options = "caps:menu";
          };
      };
      output =
        {
          "*" = {
            bg = "\"${dots + "/background-image.png"}\" fill";
          };
        }
        // (
          if config.machine == "laptop"
          then {
            "DP-1" = {
              pos = "0,0";
              res = "3840x2160";
            };
            "eDP-1" = {
              pos = "1120,2160";
              res = "1600x900";
            };
          }
          else if config.machine == "desktop"
          then {
            "DP-1" = {
              pos = "0,0";
              res = "1920x1080";
            };
            "HDMI-A-1" = {
              pos = "1920,0";
              res = "1920x1080";
            };
          }
          else {
            "eDP-1" = {
              pos = "160,1440";
              res = "2256x1504";
              scale = "1.4";
            };
            "DP-4" = {
              pos = "0,0";
              res = "3840x2160";
            };
            "DP-3" = {
              pos = "0,0";
              res = "3840x2160";
              scale = "1.5";
            };
            "DP-1" = {
              pos = "0,0";
              res = "3840x2160";
            };
          }
        );

      seat = {
        "seat0" = {
          xcursor_theme = "Dracula-cursors";
        };
      };
    };
  };
}
