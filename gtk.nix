{pkgs, ...}: {
  hm.gtk = rec {
    enable = true;
    font.name = "SauceCodePro Nerd Font Mono 10";
    iconTheme = {
      package = pkgs.dracula-theme;
      name = "Dracula-cursors";
    };
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
    gtk4.theme = theme;
  };
}
