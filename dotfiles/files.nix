{ config, ... }:

let
  inherit (config) dots;
in
{
  home.file.".ghc/ghci.conf".source = "${dots}/ghci.conf";
  home.file.".config/waybar/config".source = "${dots}/waybar";
  home.file.".config/waybar/style.css".source = "${dots}/waybar.css";
  home.file.".agda/standard-library.agda-lib".text = ''
    name: standard-library
    include: /home/alex/.nix-profile/share/agda
  '';
  home.file.".agda/libraries".text = ''
    /home/alex/.agda/standard-library.agda-lib
  '';
  home.file.".agda/defaults".text = ''
    standard-library
  '';
}
