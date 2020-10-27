{ pkgs, ... }:

{
  gtk = {
    enable = true;
    font.name = "Source Code Pro 10";
    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
  };
}
