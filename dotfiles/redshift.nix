{ pkgs, ... }:

{
  services.redshift = {
    enable = true;
    package = pkgs.gammastep;
    provider = "geoclue2";
    tray = true;
  };
}
