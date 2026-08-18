{
  config,
  lib,
  ...
}: {
  programs.sway = {
    enable = true;
    extraSessionCommands = ''
      export _JAVA_AWT_WM_NONREPARENTING=1
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_TYPE=wayland
      export MOZ_ENABLE_WAYLAND=1
    '';
    extraPackages = [];
    wrapperFeatures.gtk = true;
  };

  programs.fish = lib.mkIf (config.machine != "wsl") {
    loginShellInit = ''
      test (tty) = /dev/tty1 && exec sway
    '';
  };

  hm.wayland.windowManager.sway = {
    enable = true;
    package = null;

    systemd.variables = ["--all"];

    config = rec {
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
        names = ["Hack Nerd Font Mono 10"];
      };
      gaps = {
        inner = 10;
        outer = -10;
        bottom = -6;
        smartBorders = "on";
      };
      modifier = "Mod4";
      menu = "noctalia msg panel-toggle launcher";
      terminal = "alacritty";
      workspaceAutoBackAndForth = true;
      keybindings = lib.mkOptionDefault {
        "${modifier}+n" = "exec caja";
        "${modifier}+m" = "exec thunderbird";
        "${modifier}+b" = lib.mkForce "exec emacsclient -c";
        "${modifier}+h" = lib.mkForce "splith";
        "${modifier}+tab" = "workspace back_and_forth";
        "${modifier}+c" = "exec firefox";
        "${modifier}+p" = "exec ${./scripts/take_screenshot}";
        "${modifier}+Shift+p" = "exec ${./scripts/take_screenshot} full";
        "${modifier}+l" = "exec noctalia msg session lock";
        "XF86MonBrightnessUp" = "exec noctalia msg brightness-up";
        "XF86MonBrightnessDown" = "exec noctalia msg brightness-down";
        "XF86AudioLowerVolume" = "exec noctalia msg volume-up";
        "XF86AudioRaiseVolume" = "exec noctalia msg volume-down";
        "XF86AudioPlay" = "exec \"playerctl play\"";
        "XF86AudioPause" = "exec \"playerctl pause\"";
        "XF86AudioNext" = "exec \"playerctl next\"";
        "XF86AudioPrev" = "exec \"playerctl previous\"";
        "${modifier}+Ctrl+r" = "exec reboot";
        "${modifier}+Ctrl+k" = "exec \"shutdown -h now\"";
        "${modifier}+Shift+s" = "exec noctalia msg screenshot-region";
        "${modifier}+Ctrl+Left" = "move workspace to output left";
        "${modifier}+Ctrl+Right" = "move workspace to output right";
        "${modifier}+Ctrl+Up" = "move workspace to output up";
        "${modifier}+Ctrl+Down" = "move workspace to output down";
        "${modifier}+0" = lib.mkForce null;
        "${modifier}+Shift+0" = lib.mkForce null;
        "${modifier}+period" = "exec noctalia msg settings-toggle";
        "${modifier}+comma" = "exec noctalia msg panel-toggle control-center";
        "${modifier}+d" = "exec noctalia msg panel-toggle launcher";
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
        "1133:50504:Logitech_USB_Receiver_Mouse" = {
          accel_profile = "flat";
          left_handed = "enabled";
        };
        "7805:11320:ROCCAT_ROCCAT_Kiro_Mouse" = {
          accel_profile = "flat";
          pointer_accel = "-0.4";
        };
        "*" =
          if config.machine == "framework"
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
            bg = "\"${./background-image.png}\" fill";
          };
        }
        // (
          if config.machine == "desktop"
          then {
            "DP-1" = {
              pos = "0,0";
              res = "3440x1440";
            };
            "HDMI-A-3" = {
              pos = "3440,0";
              res = "1920x1080";
            };
          }
          else {
            "eDP-1" = {
              pos = "474,1440";
              res = "2256x1504";
              scale = "1.4";
            };
            "DP-2" = {
              pos = "0,0";
              res = "3840x2160";
              scale = "1.5";
            };
            "DP-3" = {
              pos = "0,0";
              res = "3840x2160";
              scale = "1.5";
            };
            "DP-4" = {
              pos = "0,0";
              res = "3840x2160";
            };
            "DP-1" = {
              pos = "0,0";
              res = "3840x2160";
              scale = "1.5";
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
