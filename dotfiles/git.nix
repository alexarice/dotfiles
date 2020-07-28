{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Alex Rice";
    userEmail = "alexrice999@hotmail.co.uk";
    ignores = ["*~"];
    signing = {
      key = "4B9FC04B9EE7F4AE99A7573493DDCD7A2B3F3B88";
      signByDefault = true;
    };
    extraConfig = {
      core.filemode = false;
      pull.rebase = true;
    };
  };
}
