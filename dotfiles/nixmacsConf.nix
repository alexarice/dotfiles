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
    smartparens.enable = true;
    powerline.enable = false;
    nix-update.enable = true;
    direnv.enable = true;
    which-key.enable = true;
    xah-fly-keys = {
      enable = true;
      settings.keyboard-layout = "dvorak";
      use-package.chords."nh" = "xah-fly-command-mode-activate";
    };
    use-package-chords.use-package.custom.key-chord-two-keys-delay = 0.2;
    doom-modeline = {
      enable = true;
    };
    doom-themes.use-package.custom = {
      doom-themes-enable-bold = true;
      doom-themes-enable-italic = true;
    };
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
