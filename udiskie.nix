{pkgs, ...}: {
  hm.home.packages = with pkgs; [
    udiskie
  ];

  hm.systemd.user.services.udiskie = {
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
}
