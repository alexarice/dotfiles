{ pkgs, ... }:

{
  gtk = {
    enable = true;
    font.name = "Source Code Pro 10";
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
