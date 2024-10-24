{
  pkgs,
  lib,
  ...
}: {
  programs.emacs = {
    enable = true;

    package = pkgs.emacs-pgtk;

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
            corfu-quit-no-match = true;
            corfu-auto-delay = 0;
            corfu-auto-prefix = 3;
            corfu-preselect = "'directory";
            completion-styles = "'(basic)";
          };
          bind.corfu-map."RET" = "nil";
          init = ''
            (global-corfu-mode)
          '';
        };

        "c++-mode" = {
          enable = true;
          package = [];
          external-packages = [pkgs.clang-tools];
          hook = "(c++-mode . eglot-ensure)";
        };

        cape = {
          enable = true;
          init = ''
            (add-to-list 'completion-at-point-functions #'cape-file)
            (add-to-list 'completion-at-point-functions #'cape-keyword)
            (add-to-list 'completion-at-point-functions #'cape-dabbrev)
          '';
          custom.cape-dict-case-fold = false;
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
              "." = "major-mode-bind";
              "r" = "eglot-rename";
              "g" = "magit-status-here";
              "y" = "jinx-correct";
              "t" = "fold-map";
              "w" = "delete-other-windows";
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
              "l" = "major-mode-bind";
            };
          };
        };

        envrc = {
          enable = true;
          hook = "(after-init . envrc-global-mode)";
        };

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
          external-packages = [pkgs.nil];
          hook = "(nix-mode . eglot-ensure)";
          custom.nix-indent-function = "'nix-indent-line";
        };

        python-mode = {
          enable = true;
          external-packages = [pkgs.pyright];
          hook = "(python-mode . eglot-ensure)";
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

        treesit-fold = {
          enable = true;
          hook = "(json-ts-mode . treesit-fold-mode)";
        };

        json-ts-mode = {
          enable = true;
          package = [];
          mode = ''"\\.json\\'"'';
          bind.json-ts-mode-map = {
            "<tab>" = "treesit-fold-toggle";
          };
        };

        vertico = {
          enable = true;
          demand = true;
          init = "(vertico-mode)";
          custom.vertico-cycle = true;
        };

        vertico-directory = {
          enable = config.package.vertico.enable;
          after = ["vertico"];
          demand = true;
          package = [];
          bind.vertico-map = {
            "RET" = "vertico-directory-enter";
            "DEL" = "vertico-directory-delete-char";
          };
        };

        vertico-multiform = {
          enable = config.package.vertico.enable;
          after = ["vertico"];
          demand = true;
          package = [];
          config = lib.mkIf config.package.jinx.enable ''
            (add-to-list 'vertico-multiform-categories
                         '(jinx grid (vertico-grid-annotate . 20)))
            (vertico-multiform-mode 1)
          '';
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

        auctex-latexmk = {
          enable = true;
          commands = ["auctex-latexmk-setup"];
          custom.auctex-latexmk-inherit-TeX-PDF-mode = true;
        };

        typst-ts-mode = {
          enable = true;
          package = epkgs.callPackage ./pkgs/typst-ts-mode {};
          external-packages = [
            pkgs.typst-lsp
          ];
          mode = ''"\\.typ\\'"'';
          hook = "(typst-ts-mode . eglot-ensure)";
          custom = {
            typst-ts-mode-indent-offset = 2;
          };
        };

        eglot = {
          enable = true;
          package = [];
          config = ''
            (add-to-list 'eglot-server-programs
            '((LaTeX-mode tex-mode context-mode texinfo-mode bibtex-mode) . ("texlab" :initializationOptions (:texlab (:chktex (:onOpenAndSave nil :onEdit nil))))))
            (add-to-list 'eglot-server-programs
              '(catt-mode . ("~/.cargo/bin/catt_strict" "--lsp")))
            (add-to-list 'eglot-server-programs
              '(typst-ts-mode . ("typst-lsp")))
            (add-to-list 'eglot-server-programs
              '(mlir-mode . ("/home/alex/postdoc/mlir/llvm-project/build/bin/mlir-lsp-server")))
            (add-to-list 'eglot-server-programs
              '(tablegen-mode . ("/home/alex/postdoc/mlir/llvm-project/build/bin/tblgen-lsp-server" "--tablegen-compilation-database=/home/alex/postdoc/mlir/llvm-project/build/tablegen_compile_commands.yml")))
          '';
        };

        catt-mode = {
          enable = true;
          package = epkgs.callPackage ./pkgs/catt/catt-mode.nix {};
          init = ''
            (add-hook 'catt-mode-hook 'eglot-ensure)
          '';
        };

        smartparens = {
          enable = true;
          package = epkgs.smartparens;
          init = ''
            (require 'smartparens-config)
            (eval-after-load 'LaTeX-mode '(require 'smartparens-latex))
          '';
        };

        tex = {
          enable = true;
          package = epkgs.elpaPackages.auctex;
          external-packages = [pkgs.texlab];
          init = ''
            (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
            (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
            (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
            (add-hook 'LaTeX-mode-hook 'eglot-ensure)
            (add-hook 'LaTeX-mode-hook 'outline-minor-mode)
            (add-hook 'LaTeX-mode-hook 'reftex-mode)
            (add-hook 'LaTeX-mode-hook 'visual-line-mode)
            (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
          '';
          config = ''
            (add-to-list 'TeX-view-program-selection
              '(output-pdf "Zathura"))
            (auctex-latexmk-setup)
          '';
          custom = {
            TeX-auto-save = true;
            TeX-parse-self = true;
          };
        };

        reftex = {
          enable = true;
          package = [];
          custom = {
            reftex-plug-into-AUCTeX = true;
            reftex-use-external-file-finders = true;
          };
        };

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

        haskell-mode = {
          enable = true;
          external-packages = [pkgs.haskell-language-server];
          hook = "(haskell-mode . eglot-ensure)";
        };

        agda2-mode = {
          enable = true;
          package = pkgs.agdaPackages.agda-mode epkgs;
          mode = ''"\\.l?agda\\'"'';
        };

        tuareg = {
          enable = true;
          external-packages = [pkgs.ocamlPackages.ocaml-lsp];
          hook = "(tuareg-mode . eglot-ensure)";
        };

        jinx = {
          enable = true;
          hook = "(text-mode . jinx-mode)";
        };

        llvm-ts-mode = {
          enable = true;
        };

        mlir-mode = {
          enable = true;
          package = epkgs.callPackage ./pkgs/mlir-mode {};
          hook = "(mlir-mode . eglot-ensure)";
        };

        tablegen-mode = {
          enable = true;
          package = epkgs.callPackage ./pkgs/tablegen-mode {};
          hook = "(tablegen-mode . eglot-ensure)";
        };

        yasnippet.enable = true;
      };

      hydra.hydra-agda = {
        hint = "nil";
        docText = ''

          _l_: Load         _f_: Next goal      _r_: Refine  _g_: Give       _s_: Solve         _u_: Arg
          _,_: Get context  _b_: Previous goal  _a_: Auto    _c_: Case split _e_: Eq. reasoning
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
          "e" = "reasoning-block";
          "u" = "universal-argument";
          "q" = {
            command = "nil";
            name = "cancel";
            colour = "blue";
          };
        };
      };

      hydra.hydra-latex = {
        hint = "nil";
        docText = ''

          _l_: Build         _c_: Move to cursor
          _h_: Previous page _t_: texpresso      _n_: Next Page
        '';
        bindings = {
          "l" = {
            command = "TeX-command-master";
            colour = "blue";
          };
          "h" = "texpresso-previous-page";
          "n" = "texpresso-next-page";
          "c" = {
            command = "texpresso-move-to-cursor";
            colour = "blue";
          };
          "t" = {
            command = "texpresso";
            colour = "blue";
          };
          "q" = {
            command = "nil";
            name = "cancel";
            colour = "blue";
          };
        };
      };

      keymap.my-rust-map = {
        "l" = "rustic-cargo-build";
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
        recentf-max-menu-items = 25;
        recentf-max-saved-items = 100;
        completion-cycle-threshold = 3;
        tab-always-indent = "'complete";
        read-extended-command-predicate = "#'command-completion-default-include-p";
        delete-trailing-lines = false;
      };

      global-modes = {
        tool-bar-mode = false;
        menu-bar-mode = false;
        scroll-bar-mode = false;

        global-hl-line-mode = true;
        global-display-line-numbers-mode = true;
        recentf-mode = true;
        smartparens-global-mode = true;
      };

      environment = {
        DISPLAY = "\":0\"";
      };

      preamble = ''
        (add-hook 'before-save-hook 'delete-trailing-whitespace)
        (setq-default pgtk-wait-for-event-timeout 0)
        (add-to-list 'default-frame-alist '(alpha-background . 80))

        (defun save-recentf-no-output ()
          "recentf-save-list without output"
          (interactive)
          (let ((inhibit-message t))
          (recentf-save-list)))
        (run-at-time nil (* 2 60) 'save-recentf-no-output)

        (defun copilot-tab ()
          (interactive)
          (or (copilot-accept-completion)
              (indent-for-tab-command)))

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

        (defun major-mode-bind ()
          "bind key for major mode"
          (interactive)
          (pcase major-mode
            (`agda2-mode (hydra-agda/body))
            (`LaTeX-mode (hydra-latex/body))
            (`rustic-mode (set-transient-map my-rust-map))
            ))
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
