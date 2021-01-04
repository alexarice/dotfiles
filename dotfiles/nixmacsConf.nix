{ config, lib, epkgs, pkgs, ... }:

let
  # catt-mode = epkgs.callPackage ./pkgs/catt/catt-mode.nix { };
  org-agda-export = epkgs.callPackage ./pkgs/org/ox-agda-html.nix { };
in
{
  layers = {
    agda.enable = true;
    ivy.enable = true;
    completion.enable = true;
    coq.enable = true;
    fish.enable = true;
    nix.enable = true;
    latex.enable = true;
    rust.enable = true;
    git.enable = true;
    ocaml.enable = true;
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
    };
    markdown.enable = true;
  };

  settings = {
    config-command.enable = true;
    cancel-minibuffer-with-mouse = true;
    minibuffer-inherit-input-mode = false;
  };

  custom.enable = true;

  package = {
    which-key.enable = false;
    # catt-mode = {
    #   enable = true;
    #   package = catt-mode;
    #   use-package.mode = ''"\\.catt\\'"'';
    # };
    ox-agda-html = {
      enable = true;
      package = org-agda-export;
      use-package.commands = [
        "org-publish-lagda"
      ];
    };
    haskell-mode.external-packages = [];
    direnv.enable = true;
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
