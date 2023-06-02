{
  pkgs,
  inputs,
  ...
}: {
  programs.emacs = {
    enable = true;

    package = pkgs.emacsUnstablePgtk;

    config = {
      config,
      epkgs,
      ...
    }: {
      package = {
        corfu = {
          enable = true;
          custom = {
            corfu-auto = true;
            corfu-quit-no-match = "'separator";
            corfu-auto-delay = 0;
            corfu-auto-prefix = 2;
          };
          init = ''
            (global-corfu-mode)
          '';
        };

        cape = {
          enable = true;
          init = ''
            (add-to-list 'completion-at-point-functions #'cape-dabbrev)
            (add-to-list 'completion-at-point-functions #'cape-file)
          '';
        };

        xah-fly-keys = {
          enable = true;
          diminish = "xah-fly-keys";
          config = ''
            (xah-fly-keys-set-layout "dvorak")
            (xah-fly-keys 1)
          '';
          bind = {
            "<end>" = "xah-fly-command-mode-activate";
            "<menu>" = "xah-fly-command-mode-activate";
            "<VoidSymbol>" = "xah-fly-command-mode-activate";
            "xah-fly-leader-key-map" = {
              "u" = "consult-buffer";
              "h" = "eglot-code-actions";
            };
            "xah-fly-command-map" = {
              "#" = "xah-comment-dwim";
              ";" = "self-insert-command";
              "a" = "execute-extended-command";
              "m" = "xref-find-definitions";
              "v" = "xref-go-back";
              "-" = "universal-argument";
              "b" = "consult-line";
              "'" = "eglot-format";
            };
          };
        };

        direnv.enable = true;

        doom-themes = {
          enable = true;
          config = "(load-theme 'doom-dracula t)";
        };

        doom-modeline = {
          enable = true;
          custom = {
            doom-modeline-icon = true;
            doom-themes-enable-bold = true;
          };
          config = ''
            (doom-modeline-mode 1)
          '';
        };

        nerd-icons = {
          enable = true;
          custom.nerd-icons-font-family = "SauceCodePro Nerd Font Mono";
        };

        nix-mode = {
          enable = true;
          external-packages = [inputs.nil.packages.x86_64-linux.nil];
          hook = "(nix-mode . eglot-ensure)";
          custom.nix-indent-function = "'nix-indent-line";
        };

        savehist = {
          enable = true;
          package = [];
          init = "(savehist-mode)";
          diminish = "savehist-mode";
        };

        rainbow-mode = {
          enable = true;
          hook = "prog-mode";
          diminish = "rainbow-mode";
        };

        rainbow-delimiters = {
          enable = true;
          hook = "(prog-mode . rainbow-delimiters-mode)";
          diminish = "rainbow-delimiters-mode";
        };

        vertico = {
          enable = true;
          init = "(vertico-mode)";
        };

        vertico-directory = {
          enable = config.package.vertico.enable;
          package = [];
          bind.vertico-map = {
            "RET" = "vertico-directory-enter";
            "DEL" = "vertico-directory-delete-word";
          };
        };

        orderless = {
          enable = true;
          custom = {
            completion-styles = "'(orderless basic)";
            completion-category-overrides = "'((file (styles basic partial-completion)))";
          };
        };

        marginalia = {
          enable = true;
          init = "(marginalia-mode)";
        };

        consult = {
          enable = true;
        };

        embark = {
          enable = true;
        };

        embark-consult.enable = true;

        amx = {
          enable = true;
          init = "(amx-mode)";
          diminish = "amx-mode";
        };

        magit.enable = true;

        crux.enable = true;

        git-gutter = {
          enable = true;
          hook = "(prog-mode . git-gutter-mode)";
          custom."git-gutter:update-interval" = 0.5;
          diminish = "git-gutter-mode";
        };

        git-gutter-fringe = {
          enable = true;
          config = ''
            (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
            (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
            (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom)
          '';
        };

        rustic = {
          enable = true;
          external-packages = [pkgs.rust-analyzer];
          hook = "(rustic-mode . eglot-ensure)";
          custom.rustic-lsp-setup-p = false;
        };

        yasnippet.enable = true;
      };

      global-variables = {
        delete-old-versions = -1;
        version-control = true;
        vc-make-backup-files = true;
        backup-directory-alist = "'((\".\" . \"~/.emacs.d/backups\"))";
        vc-follow-symlinks = true;
        auto-save-file-name-transforms = "'((\".*\" \"~/.emacs.d/auto-save-list/\" t))";
        inhibit-startup-screen = true;
        ring-bell-function = "'ignore";
        coding-system-for-read = "'utf-8";
        coding-system-for-write = "'utf-8";
        sentence-end-double-space = false;
        default-fill-column = 80;
        initial-scratch-message = "nil";
        gc-cons-threshold = 100000000;
        read-process-output-max = 1024 * 1024;
        enable-recursive-minibuffers = true;
        native-comp-async-report-warnings-errors = "nil";
      };

      global-modes = {
        tool-bar-mode = false;
        menu-bar-mode = false;
        scroll-bar-mode = false;

        global-hl-line-mode = true;
        global-display-line-numbers-mode = true;
        electric-pair-mode = true;
        electric-quote-mode = true;
        recentf-mode = true;
      };

      preamble = ''
        (add-hook 'before-save-hook 'delete-trailing-whitespace)

        (defun save-recentf-no-output ()
          "recentf-save-list without output"
          (interactive)
          (let ((inhibit-message t))
          (recentf-save-list)))
        (run-at-time nil (* 2 60) 'save-recentf-no-output)
      '';

      postSetup = ''
        (defun stop-using-minibuffer ()
          "kill the minibuffer"
          (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
          (abort-recursive-edit)))

        (add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)

        (define-key key-translation-map (kbd "<escape>") (kbd "C-g"))
      '';
    };
  };
}
