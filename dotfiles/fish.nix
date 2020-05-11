{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      gp = "git push";
      gc = "git commit";
      ga = "git add";
      gst = "git status";
      gr = "git rebase";
      gd = "git diff";
      sshtw = "ssh axr1014@tinky-winky.cs.bham.ac.uk";
    };
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -c";
    BROWSER = "firefox";
    XDG_CURRENT_DESKTOP = "sway";
  };

  xdg.configFile."fish/functions".source = pkgs.callPackage ./fish_prompt.nix { };
}
