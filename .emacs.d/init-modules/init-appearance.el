;;; init-appearance -- Set how emacs looks

;;; Commentary:

;;; Code:

(require 'bootstrap)


;; Highlight the current line when programming

(when window-system
  (tool-bar-mode -1)                                      ; No tool-bar
  (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))  ; No scrollbar

  ;; Theming for window mode only
  (require-package 'grandshell-theme)

  ;; Transparency
  (set-frame-parameter (selected-frame) 'alpha '(95 95))
  (add-to-list 'default-frame-alist '(alpha 95 95))

  (add-to-list 'default-frame-alist '(font . "Anonymous Pro-12"))
  (set-face-attribute 'default t :font "Anonymous Pro-12")

  (custom-set-faces
   '(region ((t (:inherit nil :background "#FFF" :foreground "#00C"))))))

(when (not window-system)
  (menu-bar-mode -1)                         ; No menubar
  ;;(add-hook 'prog-mode-hook 'hl-line-mode)  ; highlight current line

  (defun fix-tty-colors ()
    "Hack colors to be more readable on a tty with a dark background."
    (tty-color-define "Blue" 4 '(22500 22500 52000))
    (tty-color-define "Blue1" 4 '(22500 22500 52000))
    (tty-color-define "Blue2" 4 '(22500 22500 52000))
    (tty-color-define "VioletRed4" 5 '(22500 22500 46000))
    (tty-color-define "dark slate blue" 12 '(22500 22500 45000))
    (tty-color-define "color-16" 16 '(22500 22500 47000))
    (tty-color-define "color-17" 17 '(22500 22500 48000))
    (tty-color-define "color-18" 18 '(22500 22500 49000))
    (tty-color-define "color-19" 19 '(22500 22500 50000))
    (tty-color-define "color-20" 20 '(22500 22500 51000))
    (tty-color-define "color-21" 21 '(22500 22500 52000))
    )

  (add-hook 'window-setup-hook 'fix-tty-colors)

  ;; Set highlight color
  (custom-set-faces
   ;; Make diff readable
   '(cursor ((t (:background "wheat" :foreground "white"))))
   '(diff-added ((t (:inherit nil :background "dark blue"))))
   '(diff-removed ((t (:inherit nil :background "dark red"))))
   '(diff-changed ((t (:inherit nil :background "dark magenta"))))
   '(diff-header ((t (:inherit nil :background "grey10"))))
   '(diff-file-header ((t (:inherit nil :background "grey25"))))
   ;; Use dark blue for selection region
   '(region ((t (:inherit nil :foreground "#FFF" :background "#00F"))))
   ;; Use dim grey for highlights
   '(highlight ((t (:inherit region :background "grey6"))))
   '(hl-line ((t (:inherit highlight))))))

(provide 'init-appearance)
;;; init-appearance.el ends here
