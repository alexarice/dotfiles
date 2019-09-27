{ config, lib, epkgs, ... }:

{
  layers = {
    ivy.enable = true;
    completion.enable = true;
    nix.enable = true;
    latex.enable = true;
    git.enable = true;
    c.enable = true;
    org = {
      enable = true;
      agenda-files = [
        /home/alex/Dropbox/SortOutLife.org
      ];
    };
    python.enable = true;
    javascript.enable = true;
    systemd.enable = true;
    yaml.enable = true;
    mu4e.enable = true;
  };

  settings.debug.enable = true;

  package = {
    direnv.enable = true;
    xah-fly-keys = {
      enable = true;
      settings = {
        keyboard-layout = "dvorak";
        major-mode-bind-key = ".";
        command-mode-bindings = {
          "\";\"" = "self-insert-command";
          "\"#\"" = "xah-comment-dwim";
        };
      };
      use-package.chords."nh" = "xah-fly-command-mode-activate";
    };
    unicode-fonts.enable = true;
    nix-update.enable = true;
    tex.settings.TeX-view-program-selection.output-pdf = "Zathura";
    doom-modeline.use-package.custom.doom-modeline-icon = true;
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
