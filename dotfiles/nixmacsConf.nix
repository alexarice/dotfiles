{ config, lib, epkgs, ... }:

{
  config = {
    layers = {
      ivy.enable = true;
      completion = {
        enable = true;
        yas-expand-key = "C-;";
      };
      nix.enable = true;
      latex.enable = true;
      git.enable = true;
      c.enable = false;
    };

    settings.debug.enable = true;

    package.smartparens = {
      enable = true;
    };

    package.neo-theme.settings.neo-theme = "arrow";

    appearance = {
      theme = {
        enable = true;
        package = epkgs.melpaPackages.dracula-theme;
        themeName = "dracula";
      };
      fonts = {
        font = "Source Code Pro 11";
        unicode-font = "STIXGeneral";
      };
    };
  };
}
