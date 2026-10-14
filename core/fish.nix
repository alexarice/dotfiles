{pkgs, ...}: {
  hm.programs.fish = {
    enable = true;
    shellAliases = {
      gp = "git push";
      gc = "git commit";
      ga = "git add";
      gst = "git status";
      gd = "git diff";
    };
    functions = {
      fish_mode_prompt = "";
    };
  };

  hm.xdg.configFile."fish/functions/fish_prompt.fish".source = ./fish_prompt.fish;
}
