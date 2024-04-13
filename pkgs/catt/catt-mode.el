;; catt-mode.el -- CATT major emacs mode

(require 'agda-input)

(defvar catt-font-lock-keywords
 '(
   ("#.*" . 'font-lock-comment-face)
   ("\\<\\(def\\|normalise\\|assert\\|size\\|import\\|coh\\|in\\)\\>\\|:\\|=" . font-lock-keyword-face)
   ("\\<\\(comp\\|id\\)\\>\\|->" . font-lock-builtin-face)
   ;; ("\\<\\(\\)\\>" . font-lock-constant-face)
   ("\\<def[ \t]+\\([^ (=]*\\)" 1 'font-lock-function-name-face)
  )
)

(defvar catt-mode-syntax-table
  (let ((st (make-syntax-table)))
    ;; Allow some extra characters in words
    (modify-syntax-entry ?_ "w" st)
    ;; Comments
    (modify-syntax-entry ?/ ". 12" st)
    (modify-syntax-entry ?\n ">" st)
    st)
  "Syntax table for CATT major mode.")

(defvar catt-tab-width 2)
(defvar catt-mode-hook nil)

(define-derived-mode catt-mode prog-mode
  "Catt" "Major mode for Catt files."
  :syntax-table catt-mode-syntax-table
  (set (make-local-variable 'comment-start) "//")
  (set (make-local-variable 'comment-start-skip) "#+\\s-*")
  (set (make-local-variable 'font-lock-defaults) '(catt-font-lock-keywords))
  (set-input-method "Agda")
  (setq mode-name "Catt")
  (run-hooks 'catt-mode-hook)
)

(provide 'catt-mode)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.catt\\'" . catt-mode))
