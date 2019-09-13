{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      gp = "git push";
      gc = "git commit -S";
      ga = "git add";
      gst = "git status";
      gr = "git rebase -S";
      gd = "git diff";
    };
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -c";
    BROWSER = "firefox";
  };

  xdg.configFile."fish/functions".source = pkgs.callPackage ./fish_prompt.nix { };
}
