{
  config,
  lib,
  inputs,
  ...
}:
lib.mkIf (lib.elem config.machine ["desktop" "framework"]) {
  hm.imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
    recommendedServices.enable = true;
  };

  hm.wayland.windowManager.sway.extraConfig = ''
    exec noctalia
  '';

  hm.programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Dracula";
      };

      wallpaper.enabled = false;

      shell = {
        font_family = "Hack Nerd Font Mono";
        corner_radius_scale = 0.5;
        polkit_agent = true;
        screenshot.save_to_file = false;

        panel = {
          launcher_placement = "floating";
          launcher_position = "auto";
          open_near_click_launcher = true;
          clipboard_placement = "floating";
          clipboard_position = "auto";
          open_near_click_clipboard = true;
          control_center_placement = "floating";
          control_center_position = "auto";
          open_near_click_control_center = true;
          wallpaper_placement = "floating";
          wallpaper_position = "auto";
          open_near_click_wallpaper = true;
          session_placement = "floating";
          session_position = "auto";
          open_near_click_session = true;
          transparency_mode = "solid";
        };
      };

      location.auto_locate = true;

      bar.default = {
        position = "bottom";
        margin_ends = 0;
        thickness = 25;
        widget_spacing = 15;
        radius = 0;
        background_opacity = 0.5;
        dead_zone.actions.left = "panel-toggle control-center home";
        capsule = true;
        capsule_thickness = 0.9;
        capsule_padding = 8;
        capsule_radius = 8;
        capsule_group = [
          {
            enabled = true;
            id = "g1";
            members = ["battery" "cpu"];
          }
          {
            enabled = true;
            id = "g2";
            members = ["clock" "date"];
          }
        ];
        start = [
          "group:g1"
          "workspaces"
          "sway-mode"
        ];

        center = [
          "group:g2"
        ];
        end = [
          "media"
          "tray"
          "notifications"
          "clipboard"
          "network"
          "bluetooth"
          "volume"
          "brightness"
        ];
      };

      widget.media.hide_when_no_media = true;

      widget.sway-mode = {
        type = "ismay/sway-mode:sway-mode";
        capsule_fill = "primary";
        color = "on_primary";
        glyph = "";
        icon_color = "on_primary";
      };

      plugins.enabled = [
        "ismay/sway-mode"
      ];

      lockscreen = {
        blur_intensity = 0.79999998211860657;
        blurred_desktop = true;
        edge_smoothness = 0.69999998435378075;
        tint_intensity = 0.59999998658895493;
        transition = ["fade"];
        transition_duration = 500;
      };
    };
  };
}
