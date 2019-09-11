{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
  };

  xdg.configFile."fish/functions".source = pkgs.callPackage ./fish_prompt.nix { };
}
