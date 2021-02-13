(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (wheatgrass)))
 '(custom-safe-themes (quote ("08141ce5483bc173c3503d9e3517fca2fb3229293c87dc05d49c4f3f5625e1df" "26073459251085dc6f1d6f8558eead4224f9c3f0eddccd2ce3ccc0b919d8893b" default)))
 '(inhibit-startup-screen t)
 '(verilog-auto-lineup (\` declaration))
 '(verilog-auto-newline nil)
 '(verilog-highlight-grouping-keywords t)
 '(verilog-indent-level 2)
 '(verilog-indent-level-behavioral 2)
 '(verilog-indent-level-declaration 2)
 '(verilog-indent-level-directive 2)
 '(verilog-indent-level-module 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-base-error-face ((t (:inherit rainbow-delimiters-base-face :foreground "red"))))
 '(rainbow-delimiters-depth-1-face ((t (:inherit rainbow-delimiters-base-face :foreground "medium spring green"))))
 '(rainbow-delimiters-depth-2-face ((t (:inherit rainbow-delimiters-base-face :foreground "medium orchid"))))
 '(rainbow-delimiters-depth-3-face ((t (:inherit rainbow-delimiters-base-face :foreground "green"))))
 '(rainbow-delimiters-depth-4-face ((t (:inherit rainbow-delimiters-base-face :foreground "light sky blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:inherit rainbow-delimiters-base-face :foreground "dark violet"))))
 '(rainbow-delimiters-depth-6-face ((t (:inherit rainbow-delimiters-base-face :foreground "magenta"))))
 '(rainbow-delimiters-depth-7-face ((t (:inherit rainbow-delimiters-base-face :foreground "khaki"))))
 '(rainbow-delimiters-depth-8-face ((t (:inherit rainbow-delimiters-base-face :foreground "dark orange"))))
 '(rainbow-delimiters-depth-9-face ((t (:inherit rainbow-delimiters-base-face :foreground "light slate blue")))))

(setq-default indent-tabs-mode nil)

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

(global-set-key (kbd "\C-c w") 'find-file-at-point)

(global-set-key [f1] (lambda () (interactive) (shell "*shell*")))
(global-set-key [f2] (lambda () (interactive) (shell "*shell*<2>")))
(global-set-key [f3] (lambda () (interactive) (shell "*shell*<3>")))
(global-set-key [f4] (lambda () (interactive) (shell "*shell*<4>")))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t)

 ;;Prevent emacs from create tons of new windows when on a 4k screen.
  (setq split-height-threshold nil)
  (setq split-width-threshold nil)
 

;;   Allow forwards and backwards movement.
 
  (defun select-next-window ()
   "Switch to the next window"
   (interactive)
   (select-window (next-window)))
 
  (defun select-previous-window ()
   "Switch to the previous window"
   (interactive)
   (select-window (previous-window)))
 
  (global-set-key (kbd "\C-x o") 'select-next-window)
  (global-set-key (kbd "\C-x i")  'select-previous-window)
 
;; Search & Grep
;; Swap incremental search keys with regex isearch keys
 
  (global-set-key (kbd "\C-s") 'isearch-forward-regexp)
  (global-set-key (kbd "\C-r") 'isearch-backward-regexp)
  (global-set-key [(control meta s)] 'isearch-forward)
  (global-set-key [(control meta r)] 'isearch-backward)


(let ((default-directory "~/.emacs.d/qgrep/"))
    (normal-top-level-add-to-load-path '("."))
    (normal-top-level-add-subdirs-to-load-path))
 
  (autoload 'qgrep "qgrep" "Quick grep" t)
  (autoload 'qgrep-no-confirm "qgrep" "Quick grep" t)
  (autoload 'qgrep-confirm "qgrep" "Quick grep" t)
  (global-set-key (kbd "\C-c g") 'qgrep-no-confirm)
  (global-set-key (kbd "\C-c G") 'qgrep-confirm)
  ;; Stricter filters
  (setq qgrep-default-find "find . \\( -wholename '*/.svn' -o -wholename '*/obj' -o -wholename '*/.git' -o -wholename '*/sim' -o -wholename '*/VCOMP' \\) -prune -o -type f \\( '!' -name '*atdesignerSave.ses' -a \\( '!' -name '*~' \\) -a \\( '!' -name '#*#' \\) -a \\( -name '*' \\) \\) -type f -print0")
  (setq qgrep-default-grep "grep -iI -nH -e \"%s\"")


(require 'bookmark)
(defun bookmark-shell-jump (bookmark &optional display-func)
  "Allow emacs bookmarks to do a 'cd directory' if in shell mode"
  (interactive
   (list (bookmark-completing-read "Jump to bookmark"
                                   bookmark-current-bookmark)))
  (unless bookmark
    (error "No bookmark specified"))
  (if (eq major-mode 'shell-mode)
      (progn
        (goto-char (point-max))
        (comint-previous-prompt 1)
        (comint-next-prompt 1)
        (let* ((bookmark-data (bookmark-get-bookmark-record bookmark))
               (filename (cdr (assoc 'filename bookmark-data))))
          (insert (format "cd %s" filename))
          (comint-send-input)))
    (bookmark-jump bookmark)))
(global-set-key (kbd "C-x r b") 'bookmark-shell-jump)
(global-set-key (kbd "C-x r B") 'bookmark-jump)

;; open bazel files in python mode
(add-to-list 'auto-mode-alist '("\\.bzl\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\BUILD\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.vams\\'" . verilog-mode))
(add-to-list 'auto-mode-alist '("\\.sdc\\'" . tcl-mode))

;; disable line-wrapping in the buffers
(setq-default truncate-lines t)

;; rainbow delimeters for all major programming modes
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; melpa stuff
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; systemrdl-mode
(add-to-list 'load-path "~/.emacs.d/systemrdl-mode/") ; or whatever directory you chose
(require 'systemrdl-mode)
(setq auto-mode-alist (cons '("\\.rdl$" . systemrdl-mode) auto-mode-alist))

;; change all prompts to y or n
(fset 'yes-or-no-p 'y-or-n-p)

(defun align-comma (BEG END)
    "Align a set of rows by comma. Frequently used for testplans or csv"
    (interactive "r")
    (align-regexp BEG END " *\\(, *\\)" 1 2 t))


