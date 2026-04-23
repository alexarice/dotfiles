{
  hm.home = {
    file = {
      ".ghc/ghci.conf".source = ./ghci.conf;
      ".config/zathura/zathurarc".source = ./zathurarc;
    };
    sessionPath = [
      "~/.cabal/bin"
      "$HOME/.cargo/bin"
      "$HOME/.cmake/bin"
    ];
  };
}
