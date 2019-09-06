{ config, lib, epkgs, ... }:

{
  layers = {
    ivy.enable = true;
    completion.enable = true;
    nix.enable = true;
    latex.enable = true;
    git.enable = true;
    c.enable = true;
    org.enable = true;
    python.enable = true;
    javascript.enable = true;
    systemd.enable = true;
  };

  settings.debug.enable = true;

  package = {
    direnv.enable = true;
    xah-fly-keys = {
      enable = true;
      settings.keyboard-layout = "dvorak";
      use-package.chords."nh" = "xah-fly-command-mode-activate";
    };
    unicode-fonts.enable = true;
  };

  appearance = {
    theme = {
      enable = true;
      package = epkgs.doom-themes;
      themeName = "doom-dracula";
    };
    fonts = {
      font = "Source Code Pro 11";
      unicode-font = "STIXGeneral";
    };
  };
}
