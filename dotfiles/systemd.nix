{ config, pkgs, lib, setEnvironment, ... }:

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
        After = [ "local-fs.target" "network.target" ];
      };
      Install = {
        WantedBy = [ "multi-user.target" ];
      };
      Service = {
        ExecStart = "/home/alex/.dropbox-dist/dropboxd";
        RestartSec = 3;
        Restart = "on-failure";
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
    emacs = {
      Unit = {
        Description = "Nixmacs text editor";
        Documentation = "man:nixmacs(1)";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        Type = "forking";
        ExecStart = "${pkgs.bash}/bin/bash -c 'source ${setEnvironment}; exec ${pkgs.nixmacs}/bin/nixmacs --daemon'";
        ExecStop = "${pkgs.emacs}/bin/emacsclient --eval \"(kill-emacs)\"";
        Restart = "always";
      };
    };
    redshift.Install.WantedBy = lib.mkForce [ "sway-session.target" ];
  };
}
