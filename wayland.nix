{pkgs, ...}: {
  imports = [
    ./mako.nix
    ./gammastep.nix
    ./sway.nix
  ];
  config = {
    hardware = {
      graphics.enable = true;
      brillo.enable = true;
    };
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      wlr.enable = true;
    };
    environment.systemPackages = with pkgs; [
      grim
      slurp
      waybar
      swaylock
      wdisplays
      wlprop
      wldash
      wl-clipboard
    ];

    hm.home.file = {
      ".config/waybar/config".source = ./waybar;
      ".config/waybar/style.css".source = ./waybar.css;
    };

    hm.systemd.user.services.waybar = {
      Unit = {
        Description = pkgs.waybar.meta.description;
        PartOf = ["graphical-session.target"];
      };
      Install = {
        WantedBy = ["sway-session.target"];
      };
      Service = {
        ExecStart = "${pkgs.waybar}/bin/waybar";
        RestartSec = 3;
        Restart = "always";
      };
    };
  };
}
