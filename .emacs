(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d057f0430ba54f813a5d60c1d18f28cf97d271fd35a36be478e20924ea9451bd" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (nlinum-relative zenburn-theme auto-complete projectile magit evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
 (require 'use-package))

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by Nicolas Dudebout
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(ensure-package-installed 'evil
			  'magit
			  'projectile
			  'auto-complete
			  'zenburn-theme
			  'nlinum-relative
			  'elpy
			  'flycheck)

;; activate installed packages
(package-initialize)
(evil-mode t)
(ac-config-default)
(load-theme 'zenburn t)
(elpy-enable)
(global-flycheck-mode)

;relative line-numbering
(nlinum-relative-setup-evil)                    ;; setup for evil
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(setq nlinum-relative-redisplay-delay 0)        ;; delay
(setq nlinum-relative-current-symbol "")        ;; or "" for display current line number
(setq nlinum-relative-offset 1)                 ;; 1 if you want 0, 2, 3...

;smooth scrolling
(setq scroll-step 1)
(setq scroll-margin 6
    scroll-conservatively 0
    scroll-up-aggressively 0.01
    scroll-down-aggressively 0.01)
(setq-default scroll-up-aggressively 0.01
    scroll-down-aggressively 0.01)

;zoom with c-scroll
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)

;fonts
(set-face-attribute 'default nil
		    :height 140
		    :family "Noto Sans Mono")

;unbind elpy bind for c-arrows
(eval-after-load "elpy"
  '(cl-dolist (key '("C-<up>"))
     (define-key elpy-mode-map (kbd key) nil)))

(eval-after-load "elpy"
  '(cl-dolist (key '("C-<down>"))
     (define-key elpy-mode-map (kbd key) nil)))

(eval-after-load "elpy"
  '(cl-dolist (key '("s-<right>"))
     (define-key elpy-mode-map (kbd key) nil)))

(eval-after-load "elpy"
  '(cl-dolist (key '("s-<left>"))
     (define-key elpy-mode-map (kbd key) nil)))

(global-unset-key [C-up])
(global-unset-key [C-down])

;c-up/down should be jump
(global-set-key [C-up]
                (lambda () (interactive) (forward-line -10)))
(global-set-key  [C-down]
                (lambda () (interactive) (forward-line 10)))

;c-right/left should be next buffer
(setq skippable-buffers '("*Messages*" "*scratch*" "*Help*" "*Flymake log*" "*Flycheck error messages*"))

(defun my-next-buffer ()
  "next-buffer that skips certain buffers"
  (interactive)
  (next-buffer)
  (while (member (buffer-name) skippable-buffers)
    (next-buffer)))

(defun my-previous-buffer ()
  "previous-buffer that skips certain buffers"
  (interactive)
  (previous-buffer)
  (while (member (buffer-name) skippable-buffers)
    (previous-buffer)))

(global-set-key [remap next-buffer] 'my-next-buffer)
(global-set-key [remap previous-buffer] 'my-previous-buffer)

(global-set-key [s-right] 'next-buffer)
(global-set-key [s-left] 'previous-buffer)

;no toolbar
(tool-bar-mode -1)
