{ config, lib, epkgs, pkgs, ... }:
{
  layers = {
    ivy.enable = true;
    completion.enable = true;
    fish.enable = true;
    nix.enable = true;
    latex.enable = true;
    rust.enable = true;
    git.enable = true;
    python.enable = true;
    lsp = {
      enable = true;
      ui = true;
    };
  };

  settings = {
    config-command.enable = true;
    cancel-minibuffer-with-mouse = true;
    minibuffer-inherit-input-mode = false;
  };

  package = {
    which-key.enable = false;
    company.use-package.custom.company-dabbrev-downcase = "nil";

    xah-fly-keys = {
      enable = true;
      settings = {
        keyboard-layout = "dvorak";
        major-mode-bind-key = ".";
        command-mode-bindings = {
          ";" = "self-insert-command";
          "#" = "xah-comment-dwim";
        };
      };
      use-package.bind."<end>" = "xah-fly-command-mode-activate";
      use-package.bind."<menu>" = "xah-fly-command-mode-activate";
      use-package.bind."<VoidSymbol>" = "xah-fly-command-mode-activate";
    };
    unicode-fonts.enable = true;
    tex.settings.TeX-view-program-selection.output-pdf = "Zathura";
    doom-modeline.use-package.custom.doom-modeline-icon = true;
    nix-mode.use-package.demand = true;
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
