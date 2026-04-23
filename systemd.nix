{
  config,
  pkgs,
  ...
}: {
  hm.systemd.user.services = {
    waybar = {
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
    udiskie = {
      Unit = {
        Description = pkgs.udiskie.meta.description;
        PartOf = ["graphical-session.target"];
      };
      Install = {
        WantedBy = ["sway-session.target"];
      };
      Service = {
        ExecStart = "${pkgs.udiskie}/bin/udiskie";
        RestartSec = 3;
        Restart = "always";
      };
    };
    emacs = {
      Unit = {
        Description = "Emacs text editor";
        After = ["graphical-session.target"];
      };
      Install = {
        WantedBy = ["default.target"];
      };
      Service = {
        Type = "forking";
        ExecStart = "${pkgs.bash}/bin/bash -c 'source ${config.system.build.setEnvironment}; exec emacs --daemon'";
        ExecStop = "${pkgs.emacs}/bin/emacsclient --eval \"(kill-emacs)\"";
        Restart = "always";
      };
    };
  };
}
