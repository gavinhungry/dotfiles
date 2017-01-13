; (setq debug-on-error t)

(add-to-list 'load-path "~/.emacs.d/lib")

(global-set-key (kbd "C-@")
  (lambda () (interactive)
  (setq current-prefix-arg '(4)) ; C-u
  (call-interactively 'shell-command)))

; file modes
(add-to-list 'interpreter-mode-alist '("node" . js-mode))
(add-to-list 'auto-mode-alist '("\\.bashrc.local\\'" . sh-mode))

; side-by-side ediff
(custom-set-variables
  '(ediff-split-window-function (quote split-window-horizontally))
)

; 'string-prefix-p from emacs 24
(unless (fboundp 'string-prefix-p)
  (defun string-prefix-p (str1 str2 &optional ignore-case)
  (eq t (compare-strings str1 nil nil str2 0 (length str1) ignore-case))))

; linum
(global-linum-mode t)
(setq linum-format (lambda (line)
  (propertize (format (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
  (concat "%" (number-to-string w) "d ")) line) 'face 'linum)))

; terminal colors
(setq term (getenv "TERM"))
(if (or (string-prefix-p "xterm" term) (string-equal "screen" term)) (progn
  (set-face-attribute 'linum nil :foreground "gray20")
  (set-face-attribute 'mode-line nil :inverse-video nil :foreground "gray60" :background "gray20")))

; indentation
(setq default-tab-width 2)
(setq tab-width default-tab-width)
(setq-default indent-tabs-mode nil)
(global-set-key (kbd "C-x C-a") 'linum-mode)
(global-set-key "\C-i" (lambda() (interactive) (insert-char 32 tab-width)))
(global-set-key [backtab] 'indent-for-tab-command)
(global-set-key (kbd "C-x C-t") 'delete-trailing-whitespace)

; per-mode indentation
(setq sh-basic-offset tab-width sh-indentation tab-width)
(setq js-indent-level tab-width)

; scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)

; redo+
(require 'redo+)
(global-set-key "\C-\\" 'redo)
(global-set-key (kbd "C-x C-\\") 'toggle-input-method) ; remapped from C-\

; misc
(menu-bar-mode 0)
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq auto-save-list-file-name nil)
(setq auto-save-default nil)
(setq vc-follow-symlinks t)
(global-font-lock-mode 1)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(epa-file-disable)
