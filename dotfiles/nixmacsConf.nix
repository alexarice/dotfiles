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
    };

    settings = {
      line-numbers.enable = true;
      adaptive-wrap.enable = true;
      smooth-scrolling.enable = true;
      debug.enable = true;
      delete-trailing-whitespace = true;
      crux-C-a = true;
      global-hl-line = true;
      neo-theme = "arrow";
      recent-files-mode = true;
      electric-pair-mode = true;
    };

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
