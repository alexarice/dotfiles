{config, ...}: let
  dots = config.root;
in {
  hm.home = {
    file = {
      ".ghc/ghci.conf".source = "${dots}/ghci.conf";
      ".config/waybar/config".source = "${dots}/waybar";
      ".config/waybar/style.css".source = "${dots}/waybar.css";
      ".config/zathura/zathurarc".source = "${dots}/zathurarc";
    };
    sessionPath = ["~/.cabal/bin"];
  };
}
