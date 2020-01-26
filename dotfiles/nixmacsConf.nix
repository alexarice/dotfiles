{ config, lib, epkgs, ... }:

let
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
in
{
  layers = {
    agda.enable = true;
    ivy.enable = true;
    completion.enable = true;
    fish.enable = true;
    nix.enable = true;
    latex.enable = true;
    rust.enable = false;
    git.enable = true;
    c.enable = false;
    org = {
      enable = true;
      agenda-files = [
        "/home/alex/Dropbox/org/SortOutLife.org"
      ];
    };
    python.enable = true;
    javascript.enable = true;
    systemd.enable = true;
    yaml.enable = true;
    lsp.enable = true;
    haskell = {
      enable = true;
      hies = all-hies.selection { selector = p: { inherit (p) ghc865; };};
    };
    markdown.enable = true;
  };

  settings = {
    config-command.enable = true;
    cancel-minibuffer-with-mouse = true;
  };

  custom.enable = true;

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
      use-package.bind."<end>" = "xah-fly-command-mode-activate";
    };
    unicode-fonts.enable = true;
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
      unicode-font = "DejaVu Sans";
#      font = "Source Code Pro 10";
    };
  };
}
