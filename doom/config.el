;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq lsp-ui-doc-enable t
      lsp-ui-doc-delay 0.2
      lsp-enable-symbol-highlighting t
      lsp-headerline-breadcrumb-enable t
      lsp-signature-auto-activate t
      company-idle-delay 0.1
      company-minimum-prefix-length 1)



(global-set-key (kbd "C-s") #'consult-line)


(setq projectile-project-search-path '("~/go/src/github.com/kuppakoffe"))
(setq projectile-indexing-method 'alien) ;; or 'native if you want Emacs to scan files itself
(setq projectile-enable-caching t)




(use-package! eldoc-box
  :hook (eldoc-mode . eldoc-box-hover-mode))


;; (setq eldoc-box-max-pixel-width 800
;;      eldoc-box-max-pixel-height 500
;;      eldoc-box-cleanup-interval 0.5)


(setq eldoc-box-max-pixel-width 800
      eldoc-box-max-pixel-height 400
      eldoc-box-cleanup-interval 0.3)



(after! lsp-ui
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-show-with-cursor nil
        lsp-ui-doc-show-with-mouse nil
        lsp-ui-doc-position 'top ;; or try 'bottom' or 'top'
        lsp-ui-doc-use-childframe nil)) ;; this disables floating popups

(setq lsp-signature-auto-activate t)


(setq gofmt-command "goimports")
(add-hook 'go-mode-hook #'lsp-deferred)
(add-hook 'before-save-hook #'gofmt-before-save)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)

(menu-bar-mode -1)
(tool-bar-mode -1)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)



(map! :leader
      :desc "Toggle Treemacs" "o t" #'treemacs)




(require 'dap-go)
(dap-go-setup)


(map! :leader
      :desc "Magit Status" "g s" #'magit-status)

(setq treemacs-position 'right)



(use-package! protobuf-mode
  :mode ("\\.proto\\'" . protobuf-mode))



(add-hook 'rust-mode-hook 'lsp-deferred)


(defun toggle-vterm-below ()
  "Toggle vterm in a split window below.
  If vterm is open and has focus, hide it.
  If vterm is open but not focused, focus it.
  If vterm is not open, create it in a split window."
  (interactive)
  (let ((vterm-buffer (get-buffer "*vterm*"))
        (current-buffer (current-buffer)))
    (cond
     ;; If we're currently in the vterm buffer, go back to previous window
     ((eq current-buffer vterm-buffer)
      (delete-window))

     ;; If vterm exists but isn't focused, switch to it
     ((buffer-live-p vterm-buffer)
      (select-window (display-buffer vterm-buffer)))

     ;; Otherwise create a new vterm in a split below
     (t
      (split-window-below)
      (other-window 1)
      (vterm)))))

;; Define the key binding (Ctrl+`)
(global-set-key (kbd "C-`") 'toggle-vterm-below)



(set-frame-parameter nil 'alpha-background 90) ; For current frame
(add-to-list 'default-frame-alist '(alpha-background . 90)) ; For all new frames henceforth
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

(setq doom-font (font-spec :family "Fira Code" :size 16))



;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
