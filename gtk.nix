{ pkgs, ... }:

{
  gtk = {
    enable = true;
    font.name = "FiraCode Nerd Font Mono 10";
    iconTheme = {
      package = pkgs.dracula-theme;
      name = "Dracula-cursors";
    };
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
  };
}
