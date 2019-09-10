{ pkgs, lib, ... }:

{
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
}
