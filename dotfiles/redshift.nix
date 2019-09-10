{ pkgs, ... }:

{
  services.redshift = {
    enable = true;
    package = pkgs.redshift-wayland;
    latitude = "51.2092712";
    longitude = "0.2556012999999666";
  };
}
