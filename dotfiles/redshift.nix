{ pkgs, ... }:

{
  services.redshift = {
    enable = true;
    package = pkgs.redshift-wayland;
    provider = "geoclue2";
    tray = true;
  };
}
