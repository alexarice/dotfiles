{inputs, ...}: {
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

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.alex.enableGnomeKeyring = true;

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
      };

      bar.default = {
        position = "bottom";
        margin_ends = 0;
        thickness = 22;
        widget_spacing = 10;
        radius = 0;
        dead_zone.actions.left = "panel-toggle control-center home";
        capsule = true;
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

      plugins.enabled = [
        "noctalia/bitwarden"
      ];
    };
  };
}
