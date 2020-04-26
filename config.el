;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Sumit"
      user-mail-address "sumitbuknp@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Fira Code Medium" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(add-hook 'after-init-hook #'global-emojify-mode)
(global-auto-revert-mode t)
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.






(use-package! scrollkeeper)
(global-set-key [remap scroll-up-command] #'scrollkeeper-contents-up)
(global-set-key [remap scroll-down-command] #'scrollkeeper-contents-down)







(use-package! rainbow-delimiters
  :config
  (custom-set-faces
   '(rainbow-delimiters-mismatched-face ((t (:foreground "white" :background "red" :weight bold))))
   '(rainbow-delimiters-unmatched-face ((t (:foreground "white" :background "red" :weight bold))))

   ;; show parents (in case of rainbow failing !)
   '(show-paren-match ((t (:foreground "white" :background "green" :weight bold))))
   '(show-paren-mismatch ((t (:foreground "white" :background "red" :weight bold)))))
  ;;  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )
;; highlight brackets
(setq show-paren-style 'parenthesis)









  (use-package! counsel
    :hook
    (after-init . ivy-mode)
    (counsel-grep-post-action . better-jumper-set-jump)
    :diminish ivy-mode
    :config
    (setq counsel-find-file-ignore-regexp "\\(?:^[#.]\\)\\|\\(?:[#~]$\\)\\|\\(?:^Icon?\\)"
          counsel-describe-function-function #'helpful-callable
          ncounsel-describe-variable-function #'helpful-variable
          ;; Add smart-casing (-S) to default command arguments:
          counsel-rg-base-command "rg -S --no-heading --line-number --color never %s ."
          counsel-ag-base-command "ag -S --nocolor --nogroup %s"
          counsel-pt-base-command "pt -S --nocolor --nogroup -e %s"
          counsel-find-file-at-point t)
       )

     (use-package! ivy-rich
       :config
       (ivy-rich-mode 1)
       (setq ivy-format-function #'ivy-format-function-line))
     ;;[[https://github.com/gilbertw1/better-jumper][gilbertw1/better-jumper: A configurable jump list implementation for Emacs]]







(after! company
  (setq company-idle-delay 0
        company-minimum-prefix-length 1
        company-transformers nil)
  (setq company-show-numbers t)
  (define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
  (define-key company-active-map (kbd "C-j") 'company-select-previous-or-abort)

(defun ora-company-number ()
  "Forward to `company-complete-number'.
Unless the number is potentially part of the candidate.
In that case, insert the number."
  (interactive)
  (let* ((k (this-command-keys))
         (re (concat "^" company-prefix k)))
    (if (or (cl-find-if (lambda (s) (string-match re s))
                        company-candidates)
            (> (string-to-number k)
               (length company-candidates))
            (looking-back "[0-9]+\\.[0-9]*" (line-beginning-position)))
        (self-insert-command 1)
      (company-complete-number
       (if (equal k "0")
           10
         (string-to-number k))))))

(defun ora--company-good-prefix-p (orig-fn prefix)
  (unless (and (stringp prefix) (string-match-p "\\`[0-9]+\\'" prefix))
    (funcall orig-fn prefix)))
(advice-add 'company--good-prefix-p :around #'ora--company-good-prefix-p)

(let ((map company-active-map))
  (mapc (lambda (x) (define-key map (format "%d" x) 'ora-company-number))
        (number-sequence 0 9))
  (define-key map " " (lambda ()
                        (interactive)
                        (company-abort)
                        (self-insert-command 1)))
  (define-key map (kbd "<return>") nil))
  )





(set-company-backend! '(nix-mode)
  '(:separate company-nixos-options
              company-tabnine
              company-files
              company-yasnippet
              ))

;;  (set-company-backend! 'sh-mode nil) ; unsets backends for sh-mode
(set-company-backend! '(org-mode)
  '(:separate company-english-helper-search
              company-tabnine
              company-files
              company-yasnippet
              ))
(set-company-backend! '(c-mode
                        c++-mode
                        ess-mode
                        haskell-mode
                        ;;emacs-lisp-mode
                        lisp-mode
                        sh-mode
                        php-mode
                        python-mode
                        go-mode
                        ruby-mode
                        rust-mode
                        js-mode
                        css-mode
                        web-mode
                        )
  '(:separate company-tabnine
              company-files
              company-yasnippet))

(setq +lsp-company-backend '(company-lsp :with company-tabnine :separate))


(use-package! awesome-pair)



(use-package! rainbow-delimiters
  :config
  (custom-set-faces
   '(rainbow-delimiters-mismatched-face ((t (:foreground "white" :background "red" :weight bold))))
   '(rainbow-delimiters-unmatched-face ((t (:foreground "white" :background "red" :weight bold))))

   ;; show parents (in case of rainbow failing !)
   '(show-paren-match ((t (:foreground "white" :background "green" :weight bold))))
   '(show-paren-mismatch ((t (:foreground "white" :background "red" :weight bold)))))
  ;;  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )
;; highlight brackets
(setq show-paren-style 'parenthesis)










(use-package! centaur-tabs
  :config
 (setq centaur-tabs-style "bar"
	  centaur-tabs-height 32
	  centaur-tabs-set-icons t
	  centaur-tabs-set-modified-marker t
	  centaur-tabs-show-navigation-buttons t
	  centaur-tabs-set-bar 'under
	  x-underline-at-descent-line t)
   (centaur-tabs-headline-match)
   ;; (setq centaur-tabs-gray-out-icons 'buffer)
   ;; (centaur-tabs-enable-buffer-reordering)
   ;; (setq centaur-tabs-adjust-buffer-order t)
   (centaur-tabs-mode t)
   (centaur-tabs-enable-buffer-reordering)
   (centaur-tabs-group-by-projectile-project)
   (setq uniquify-separator "/")
   (setq uniquify-buffer-name-style 'forward)
   )
  

(centaur-tabs-group-by-projectile-project)





