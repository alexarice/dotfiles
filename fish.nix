{pkgs, ...}: {
  programs.fish.enable = true;

  hm = {
    programs.fish = {
      enable = true;
      shellAliases = {
        gp = "git push";
        gc = "git commit";
        ga = "git add";
        gst = "git status";
        gd = "git diff";
      };
    };

    home.sessionVariables = {
      EDITOR = "emacsclient -c";
      BROWSER = "firefox";
    };

    xdg.configFile."fish/functions".source = pkgs.callPackage ./fish_prompt.nix {};
  };
}
