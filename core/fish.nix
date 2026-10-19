{config, ...}: {
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
      nix-rebuild = ''
        sudo nixos-rebuild switch --flake $HOME/dotfiles#${config.machine} --keep-going --print-build-logs $argv
      '';
      nix-clean = ''
        sudo nix-collect-garbage -d && nix-collect-garbage -d && sudo nixos-rebuild boot --flake $HOME/dotfiles#${config.machine}
      '';
    };
  };

  hm.xdg.configFile."fish/functions/fish_prompt.fish".source = ./fish_prompt.fish;
}
