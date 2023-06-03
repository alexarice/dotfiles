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
              "e" = "pp-eval-expression";
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
              "l" = "my-agda-map";
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
        };

        rainbow-mode = {
          enable = true;
          hook = "prog-mode";
        };

        rainbow-delimiters = {
          enable = true;
          hook = "(prog-mode . rainbow-delimiters-mode)";
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
        };

        magit.enable = true;

        crux.enable = true;

        git-gutter = {
          enable = true;
          hook = "(prog-mode . git-gutter-mode)";
          custom."git-gutter:update-interval" = 0.5;
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

        agda2-mode = {
          enable = true;
          mode = ''"\\.l?agda\\'"'';
        };

        yasnippet.enable = true;
      };

      hydra.hydra-agda = {
        hint = "nil";
        docText = ''

          _l_: Load         _f_: Next goal      _r_: Refine  _g_: Give       _s_: Solve
          _,_: Get context  _b_: Previous goal  _a_: Auto    _c_: Case split
        '';
        bindings = {
          "l" = "agda2-load";
          "f" = "agda2-next-goal";
          "b" = "agda2-previous-goal";
          "r" = "agda2-refine";
          "g" = "agda2-give";
          "c" = "agda2-make-case";
          "," = "agda2-goal-and-context";
          "a" = "agda2-auto-maybe-all";
          "s" = "agda2-solve-maybe-all";
          "q" = {
            command = "nil";
            name = "cancel";
            colour = "blue";
          };
        };
      };

      keymap.my-agda-map = {
       "l" = "agda2-load";
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
