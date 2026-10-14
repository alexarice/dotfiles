{
  config,
  pkgs,
  ...
}: {
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
        sudo unbuffer nixos-rebuild switch --flake $HOME/dotfiles#${config.machine} --keep-going $argv |& nom
      '';
    };
  };

  hm.home.packages = with pkgs; [
    nix-output-monitor
    expect
  ];

  hm.xdg.configFile."fish/functions/fish_prompt.fish".source = ./fish_prompt.fish;
}
