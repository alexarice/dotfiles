{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;

    package = pkgs.emacsUnstablePgtk;

    config = {
      package = {
        meow = {
          enable = true;
          demand = true;
          config = ''
            (setq meow-cheatsheet-layout meow-cheatsheet-layout-dvorak)
            (meow-define-keys 'insert '("<menu>" . meow-insert-exit))
            (meow-leader-define-key
              '("1" . meow-digit-argument)
              '("2" . meow-digit-argument)
              '("3" . meow-digit-argument)
              '("4" . meow-digit-argument)
              '("5" . meow-digit-argument)
              '("6" . meow-digit-argument)
              '("7" . meow-digit-argument)
              '("8" . meow-digit-argument)
              '("9" . meow-digit-argument)
              '("0" . meow-digit-argument)
              '("/" . meow-keypad-describe-key)
              '("?" . meow-cheatsheet)
              '("SPC" . meow-M-x))
            (meow-motion-overwrite-define-key
              ;; custom keybinding for motion state
              '("<escape>" . ignore))
            (meow-normal-define-key
            '("0" . meow-expand-0)
              '("9" . meow-expand-9)
              '("8" . meow-expand-8)
              '("7" . meow-expand-7)
              '("6" . meow-expand-6)
              '("5" . meow-expand-5)
              '("4" . meow-expand-4)
              '("3" . meow-expand-3)
              '("2" . meow-expand-2)
              '("1" . meow-expand-1)
              '("-" . negative-argument)
              '(";" . meow-reverse)
              '("," . meow-inner-of-thing)
              '("." . meow-bounds-of-thing)
              '("<" . meow-beginning-of-thing)
              '(">" . meow-end-of-thing)
              '("a" . meow-append)
              '("A" . meow-open-below)
              '("b" . meow-back-word)
              '("B" . meow-back-symbol)
              '("c" . meow-prev)
              '("C" . meow-prev-expand)
              '("d" . meow-delete)
              '("D" . meow-backward-delete)
              '("e" . meow-line)
              '("E" . meow-goto-line)
              '("f" . meow-find)
              '("g" . meow-cancel-selection)
              '("G" . meow-grab)
              '("h" . meow-left)
              '("H" . meow-left-expand)
              '("i" . meow-insert)
              '("I" . meow-open-above)
              '("j" . meow-join)
              '("k" . meow-kill)
              '("l" . meow-till)
              '("m" . meow-mark-word)
              '("M" . meow-mark-symbol)
              '("n" . meow-right)
              '("N" . meow-right-expand)
              '("o" . meow-block)
              '("O" . meow-to-block)
              '("p" . meow-change)
              '("P" . embark-act)
              '("q" . meow-quit)
              '("Q" . meow-goto-line)
              '("r" . meow-replace)
              '("R" . meow-swap-grab)
              '("s" . meow-search)
              '("t" . meow-next)
              '("T" . meow-next-expand)
              '("u" . meow-undo)
              '("U" . meow-undo-in-selection)
              '("v" . meow-visit)
              '("w" . meow-next-word)
              '("W" . meow-next-symbol)
              '("x" . meow-save)
              '("X" . meow-sync-grab)
              '("y" . meow-yank)
              '("z" . meow-pop-selection)
              '("'" . repeat)
              '("<escape>" . ignore)
              '("<menu>" . ignore))
            (meow-global-mode 1)
          '';
        };

        doom-themes = {
          enable = true;
          config = "(load-theme 'doom-dracula t)";
        };

        nix-mode = {
          enable = true;
          external-packages = [ pkgs.nil ];
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
          bind = {
            "C-c b" = "consult-buffer";
          };
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

        rust-mode = {
          enable = true;
          external-packages = [ pkgs.rust-analyzer ];
          hook = "(rust-mode . eglot-ensure)";
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
    };
  };
}
