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
      functions = {
        fish_mode_prompt = "";
      };
    };

    xdg.configFile."fish/functions/fish_prompt.fish".source = ./fish_prompt.fish;

    programs.nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    home.sessionVariables = {
      EDITOR = "emacsclient -c";
      BROWSER = "firefox";
    };

    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      keymap.mgr.prepend_keymap = [
        { on = "c"; run = "arrow prev"; }
        { on = "t"; run = "arrow next"; }
        { on = "h"; run = "leave"; }
        { on = "n"; run = "enter"; }
      ];
      shellWrapperName = "y";
      initLua = ''
        require("session"):setup {
	        sync_yanked = true,
        }
      '';
    };
  };
}
