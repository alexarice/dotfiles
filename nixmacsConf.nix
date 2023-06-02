{
  config,
  lib,
  epkgs,
  pkgs,
  ...
}: let
  catt-mode = epkgs.callPackage ./pkgs/catt/catt-mode.nix {};
  org-agda-export = epkgs.callPackage ./pkgs/org/ox-agda-html.nix {};
in {
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
    lsp = {
      enable = true;
      ui = true;
    };
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

  init-el.preamble = ''
    (defun reasoning-block (n)
      (interactive "nLines: ")
      (let ((indent (current-indentation)))
           (progn (defun go (n)
         (if (> n 0) (progn
                (insert (make-string (+ 2 indent) ?\s))
                (insert "?\n")
                (insert (make-string (+ 4 indent) ?\s))
                (insert "≈⟨ ? ⟩\n")
                (go (- n 1)))))
            (insert "begin\n")
            (go n)
            (insert (make-string (+ 2 indent) ?\s))
            (insert "? ∎"))))
  '';

  custom.enable = true;

  keybindings.hydra.hydra-agda.bindings."e" = {
    command = "reasoning-block";
    colour = "blue";
  };

  package = {
    which-key.enable = false;
    company.use-package.custom.company-dabbrev-downcase = "nil";
    catt-mode = {
      enable = true;
      package = catt-mode;
      use-package.mode = ''"\\.catt\\'"'';
    };
    haskell-mode.external-packages = [];
    direnv.enable = true;
    org-roam = {
      enable = true;
      settings.directory = "~/Dropbox/roam";
    };
    org-ref = {
      enable = true;
      settings.bibliography = ''"/home/alex/Dropbox/citations/citations.bib"'';
      use-package.custom.org-ref-pdf-directory = ''"/home/alex/Dropbox/citations"'';
    };
    ivy-bibtex.enable = true;
    org-roam-bibtex.enable = true;
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
