; (setq debug-on-error t)

(add-to-list 'load-path "~/.emacs.d/lib")

; file modes
(add-to-list 'auto-mode-alist '("/\\.bash_profile\\." . sh-mode))
(add-to-list 'auto-mode-alist '("/\\.bashrc\\." . sh-mode))
(add-to-list 'auto-mode-alist '("/PKGBUILD$" . sh-mode))

(add-to-list 'auto-mode-alist '("\\.eslintrc$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.json5$" . js-mode))
(add-to-list 'interpreter-mode-alist '("node" . js-mode))

(autoload 'markdown-mode "markdown-mode" t)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

(add-to-list 'auto-mode-alist '("\\.tmpl$" . html-mode))

(add-to-list 'auto-mode-alist '("\\.eql$" . sql-mode))
(add-to-list 'auto-mode-alist '("/q$" . sql-mode))

; file modes - systemd units
(add-to-list 'auto-mode-alist '("\\.automount$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.mount$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.path$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.service$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.slice$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.socket$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.target$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.timer$" . conf-mode))

(require 'yaml-mode) ; emacs-yaml-mode
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

; line numbers
(global-display-line-numbers-mode)
(global-set-key (kbd "C-x C-a") 'display-line-numbers-mode)

(defun display-line-numbers-update ()
  (setq display-line-numbers-width (length (number-to-string (count-lines (point-min) (point-max))))))
(add-hook 'post-command-hook 'display-line-numbers-update)

; side-by-side ediff
(custom-set-variables
  '(ediff-split-window-function 'split-window-horizontally)
)

; 'string-prefix-p from emacs 24
(unless (fboundp 'string-prefix-p)
  (defun string-prefix-p (str1 str2 &optional ignore-case)
  (eq t (compare-strings str1 nil nil str2 0 (length str1) ignore-case))))

; search colors
(set-face-attribute 'isearch nil :background "cyan" :foreground "white")
(set-face-attribute 'lazy-highlight nil :background "blue" :foreground "white")

; terminal colors
(set-face-foreground 'font-lock-comment-face "red")
(setq term (getenv "TERM"))
(if (or (string-prefix-p "xterm" term) (string-equal "screen" term)) (progn
  (set-face-attribute 'line-number nil :foreground "gray20")
  (set-face-attribute 'mode-line nil :inverse-video nil :foreground "gray60" :background "gray20")))

; man colors
(require 'man)
(set-face-attribute 'Man-overstrike nil :inherit 'bold :foreground "blue")
(set-face-attribute 'Man-underline nil :inherit 'bold :foreground "green")

; indentation
(setq default-tab-width 2)
(setq tab-width default-tab-width)
(setq-default indent-tabs-mode nil)
(global-set-key "\t" (lambda() (interactive) (insert-char 32 default-tab-width)))
(global-set-key [backtab] 'indent-for-tab-command)
(setq sh-basic-offset tab-width sh-indentation tab-width)
(setq js-indent-level tab-width)

; scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)

(global-set-key (quote [M-down]) 'scroll-up-line)
(global-set-key (quote [M-up]) 'scroll-down-line)

; redo+
(require 'redo+)
(global-set-key "\C-\\" 'redo)
(global-set-key (kbd "C-x C-\\") 'toggle-input-method) ; remapped from C-\

; keys
(global-set-key (kbd "C-x C-t") 'delete-trailing-whitespace)
(global-set-key (kbd "C-x :") 'goto-line)
(global-set-key (kbd "C-x @")
  (lambda () (interactive)
  (setq current-prefix-arg '(4)) ; C-u
  (call-interactively 'shell-command)))

; misc
(menu-bar-mode 0)
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq make-backup-files nil)
(setq auto-save-list-file-name nil)
(setq auto-save-default nil)
(setq vc-follow-symlinks t)
(setq show-paren-mode nil)
(setq large-file-warning-threshold 67108864) ; 64MB
(global-font-lock-mode 1)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(epa-file-disable)
