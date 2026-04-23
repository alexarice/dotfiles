{
  hm.home = {
    file = {
      ".ghc/ghci.conf".source = ./ghci.conf;
      ".config/waybar/config".source = ./waybar;
      ".config/waybar/style.css".source = ./waybar.css;
      ".config/zathura/zathurarc".source = ./zathurarc;
    };
    sessionPath = [
      "~/.cabal/bin"
      "$HOME/.cargo/bin"
      "$HOME/.cmake/bin"
    ];
  };
}
