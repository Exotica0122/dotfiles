;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


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
;; (setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;    doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

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

;; Enable line numbers globally
(setq display-line-numbers-type 'relative)  ;; relative numbering
(global-display-line-numbers-mode t)

;; Make the current line number stand out
(custom-set-faces
 '(line-number-current-line ((t (:foreground "light sky blue" :weight bold)))))

;; Keep at least 10 lines of margin from top/bottom when moving cursor
(setq scroll-margin 10)

;; Optional: scroll one line at a time
(setq scroll-conservatively 1
      scroll-preserve-screen-position t)

(setq doom-font                (font-spec :family "JetBrainsMono Nerd Font"  :size 16)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 16)
      doom-modeline-vcs-max-length 40 ;; to display branch name
      display-line-numbers-type 'relative)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)
(add-to-list 'default-frame-alist '(undecorated-round . t))

;; Open vterm with SPC t v
(map! :leader
      :desc "Open vterm" "v t" #'vterm)

;; Set the desired Catppuccin flavor
(setq catppuccin-flavor 'mocha) ;; Options: 'latte, 'frappe, 'macchiato, 'mocha

;; Treemacs
;; Enable icons
(after! treemacs
  (treemacs-load-theme "all-the-icons"))

(after! org-present
  (add-hook 'org-present-mode-hook
            (lambda ()
              (org-display-inline-images)
              (org-present-read-only)
              ;; (org-present-hide-cursor)
              ;; (writeroom-mode 1)
              (display-line-numbers-mode 0)))
  (add-hook 'org-present-mode-quit-hook
            (lambda()
              (org-remove-inline-images)
              (org-present-read-write)
              ;; (org-present-show-cursor)
              (visual-fill-column-mode 0)
              ;; (writeroom-mode 0)
              (display-line-numbers-mode 1)))
  (setq org-present-hide-stars-in-headings nil
        org-present-one-big-page nil
        org-present-startup-folded t))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((mermaid . t)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((typescript . t)
   ))

(after! org
  (setq org-log-into-drawer t)
  )
