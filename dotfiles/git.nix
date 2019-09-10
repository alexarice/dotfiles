{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Alex Rice";
    userEmail = "alexrice999@hotmail.co.uk";
    ignores = ["*~"];
    extraConfig.core.filemode = false;
  };
}
