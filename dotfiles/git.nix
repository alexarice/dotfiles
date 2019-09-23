{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Alex Rice";
    userEmail = "alexrice999@hotmail.co.uk";
    ignores = ["*~"];
    signing.signByDefault = true;
    extraConfig.core.filemode = false;
  };
}
