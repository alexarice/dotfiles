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
    yaml.enable = true;
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
    nix-update.enable = true;
    tex.settings.TeX-view-program-selection.output-pdf = "Zathura";
  };

  appearance = {
    theme = {
      enable = true;
      package = epkgs.doom-themes;
      themeName = "doom-dracula";
      extraConfig = ''
        ; Enable flashing mode-line on errors
        (doom-themes-visual-bell-config)

        ;; Enable custom neotree theme (all-the-icons must be installed!)
        (doom-themes-neotree-config)

        (doom-themes-org-config)
      '';
    };
    fonts = {
      font = "Source Code Pro 10";
      unicode-font = "STIXGeneral";
    };
  };
}
