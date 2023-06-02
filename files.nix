{config, ...}: let
  inherit (config) dots;
in {
  home.file.".ghc/ghci.conf".source = "${dots}/ghci.conf";
  home.file.".config/waybar/config".source = "${dots}/waybar";
  home.file.".config/waybar/style.css".source = "${dots}/waybar.css";
  home.file.".config/zathura/zathurarc".source = "${dots}/zathurarc";
  home.sessionPath = ["~/.cabal/bin"];
}
