;;; init-go --- Go programming environment
;;;
;;; Commentary:
;;;
;;; Code:

(require 'bootstrap)

(require-package 'go-mode 'evil)

;; Use evil
(evil-set-initial-state 'go-mode 'normal)

;; Set definition jumping
;; To install: go get -u code.google.com/p/rog-go/exp/cmd/godef
(evil-define-key
  'normal go-mode-map (kbd "M-.") 'godef-jump)
(evil-define-key
  'normal go-mode-map (kbd "M-,") 'pop-tag-mark)
(evil-define-key 'motion go-mode-map "gd" 'godef-jump)
(evil-define-key 'motion go-mode-map "gb" 'pop-tag-mark)
(defun set-godef-jumping-keys ()
  "Set 'M-.' and 'M-,' to jump to golang definitions and back."
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-,") 'pop-tag-mark))
(add-hook 'go-mode-hook #'set-godef-jumping-keys)

;; godoc
;; go get golang.org/x/tools/cmd/godoc
(add-hook
 'go-mode-hook
 (lambda ()
   (evil-ex-define-cmd "godoc" 'godoc)
   (define-key evil-normal-state-map ",?" 'godoc)))

;; godef-describe hacks
(add-hook
 'go-mode-hook
 (lambda ()
   (evil-ex-define-cmd "t[ype]" 'godef-describe)
   (evil-ex-define-cmd "godef-describe" 'godef-describe)))

;; gofmt smart formatting
(defun fix-ethan-wspace-tabs ()
  "Fixes ethan-wspace so it can get along with gofmt."
  (setq-local ethan-wspace-errors
              (remove 'tabs ethan-wspace-errors))
  (ethan-wspace-highlight-tabs-mode 0)
  (ethan-wspace-clean-tabs-mode 0))

(add-hook 'go-mode-hook #'fix-ethan-wspace-tabs)

(defun set-indent-tabs-mode-for-gofmt ()
  "Set 'indent-tabs-mode' for compatibility with gofmt."
  (setq-local indent-tabs-mode t))
(add-hook 'go-mode-hook #'set-indent-tabs-mode-for-gofmt)

(add-hook 'before-save-hook 'gofmt-before-save)
(evil-define-key 'normal go-mode-map ">" 'gofmt)
(evil-define-key 'normal go-mode-map "<" 'gofmt)

;; flycheck-mode
(add-hook 'go-mode-hook 'flycheck-mode)

;; Autocomplete
;; To install: go get -u github.com/nsf/gocode
(require-package 'company 'company-go)

(defun setup-company-go ()
  "Hook for running on company-go."
  (set (make-local-variable 'company-backends) '(company-go)))
(add-hook 'go-mode-hook #'setup-company-go)

;; Custom compile command
;; To install: go get -u code.google.com/p/go.tools/cmd/vet
(defun setup-go-compile-command ()
  "Hook for setting up compile command for go."
  (unless (string-match "go" compile-command)
    (set (make-local-variable 'compile-command)
         "go build -v && go test -v && go vet")
    (local-set-key (kbd "C-c C-l") 'compile)))
(add-hook 'go-mode-hook #'setup-go-compile-command)

(provide 'init-go)
;;; init-go.el ends here
