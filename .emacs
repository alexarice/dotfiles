(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(package-install-selected-packages)

;; Turn off unneeded stuff
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)

;; AucTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
;; (setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(setq TeX-PDF-mode t)
(setq TeX-view-program-list '(("Evince" "evince --page-index=%(outpage) %o")))
(setq TeX-view-program-selection '((output-pdf "Evince")))

(add-hook 'after-init-hook 'global-company-mode)
(require 'company-auctex)
(company-auctex-init)

;; adaptive-wrap
(require 'adaptive-wrap)
(setq-default adaptive-wrap-extra-indent 2)
(add-hook 'visual-line-mode-hook #'adaptive-wrap-prefix-mode)
(global-visual-line-mode +1)

;;flyspell
(setq ispell-list-command "--list")
(add-hook 'LaTeX-mode-hook
          '(lambda ()
             (setq ispell-tex-skip-alists
                   (list
                    (append
                     (car ispell-tex-skip-alists) 
                     '(("[^\\]\\$" . "[^\\]\\$")))
                    (cadr ispell-tex-skip-alists))) ))

;;haskell
(require 'haskell-mode)

;;; example setting for Mizar mode
(setq require-final-newline t)
(add-to-list 'load-path "/usr/local/share/mizar/")
 (autoload 'mizar-mode "mizar" "Major mode for editing Mizar articles." t)
 (autoload 'mmlquery-decode "mizar")
 (autoload 'mmlquery-mode "mizar")
 (setq auto-mode-alist (append '(  ("\\.miz" . mizar-mode)
                                   ("\\.abs" . mizar-mode))
 			      auto-mode-alist))
 (setq format-alist 
      (append  '(
		 (text/mmlquery "Extended MIME text/mmlquery format." 
		  "::[ \t]*Content-[Tt]ype:[ 	]*text/mmlquery"
		  mmlquery-decode nil nil mmlquery-mode))
format-alist))
	  
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-item-indent 0)
 '(TeX-electric-sub-and-superscript nil)
 '(TeX-save-query nil)
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(TeX-view-evince-keep-focus t)
 '(custom-enabled-themes (quote (dracula)))
 '(custom-safe-themes
   (quote
    ("eecacf3fb8efc90e6f7478f6143fd168342bbfa261654a754c7d47761cec07c8" default)))
 '(latex-run-command "pdflatex")
 '(package-selected-packages
   (quote
    (flycheck-haskell company-cabal company-reftex company-ghc company-ghci dracula-theme haskell-mode company-auctex company-bibtex auctex company company-math adaptive-wrap))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



