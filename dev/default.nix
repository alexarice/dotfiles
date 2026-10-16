{lib, ...}: {
  imports = (import ../lib {inherit lib;}).importFiles ./. ++ [./emacs];
}
