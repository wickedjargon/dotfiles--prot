(prot-emacs-configure
  (:delay 1)

;;;; General settings

  (setq evil-want-C-i-jump t)
  (setq evil-want-C-u-scroll t) ; Vim style
  (setq evil-want-C-d-scroll t)
  (setq evil-want-C-u-delete nil) ; I can use Emacs keys in insert mode
  (setq evil-want-C-w-delete nil) ; I can use Emacs keys in insert mode
  (setq evil-want-C-h-delete nil) ; I can use Emacs keys in insert mode
  (setq evil-disable-insert-state-bindings t)
  (setq evil-want-C-g-bindings nil)
  (setq evil-want-C-w-in-emacs-state nil)
  (setq evil-want-change-word-to-end nil)
  (setq evil-want-Y-yank-to-eol t) ; consistent with D
  (setq evil-want-abbrev-expand-on-insert-exit nil) ; expand abbrevs outright
  (setq evil-want-empty-ex-last-command t)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-minibuffer nil)
  (setq evil-toggle-key "<f12>") ; I seldom need this, so putting it somewhere far
  (setq evil-respect-visual-line-mode nil)
  (setq evil-search-module 'isearch)
  (setq evil-symbol-word-search t)
  (setq evil-magic nil) ; not applicable for `evil-search-module' isearch module
  (setq evil-ex-search-vim-style-regexp nil) ; not for isearch
  (setq evil-shift-width tab-width)
  (setq evil-default-cursor t)
  (setq evil-start-of-line nil)
  (setq evil-repeat-move-cursor t)
  (setq evil-cross-lines t)
  (setq evil-backspace-join-lines t)
  (setq evil-move-cursor-back nil) ; Emacs style, not Vim
  (setq evil-move-beyond-eol t) ; Emacs style, not Vim
  (setq evil-repeat-find-to-skip-next t)
  (setq evil-kbd-macro-suppress-motion-error nil) ; never suppress errors in kmacros, Emacs-style
  (setq evil-track-eol nil)
  (setq evil-mode-line-format '(before . prot-modeline-buffer-identification))
  (setq evil-mouse-word 'evil-word)
  (setq evil-bigword "^ \t\r\n")
  (setq evil-want-fine-undo t)
  (setq evil-regexp-search nil)
  (setq evil-search-wrap t)
  (setq evil-search-wrap-ring-bell t) ; TODO does this quit keyboard macros, specifically with C-u 0?
  (setq evil-flash-delay 0.5)
  (setq evil-auto-balance-windows window-combination-resize)
  (setq evil-split-window-below nil)
  (setq evil-vsplit-window-right nil)
  (setq evil-esc-delay 0.01)
  (setq evil-intercept-esc 'always)
  (setq evil-show-paren-range 1)
  (setq evil-ex-hl-update-delay lazy-highlight-initial-delay)
  (setq evil-highlight-closing-paren-at-point-states '(not emacs insert replace))
  (setq evil-kill-on-visual-paste nil) ; Emacs style, not Vim
  (setq evil-echo-state nil) ; be silent
  (setq evil-complete-all-buffers t) ; TODO C-n and C-p in insert mode
  (setq evil-lookup-func #'man) ; TODO K in normal mode
  (setq evil-default-state 'normal) ; check `evil-set-initial-state'
  ;; evil-buffer-regexps
  ;; evil-intercept-maps
  ;; evil-motions
  ;; evil-visual-newline-commands
  (setq evil-v$-excludes-newline nil)
  (setq evil-text-object-change-visual-type t)
  ;; evil-ex-complete-emacs-commands 'in-turn
  ;; evil-ex-visual-char-range nil
  (setq evil-ex-interactive-search-highlight 'selected-window)
  (setq evil-ex-search-persistent-highlight t)
  (setq evil-ex-search-case 'smart)
  (setq evil-ex-substitute-case nil) ; use `evil-ex-search-case'
  (setq evil-ex-search-incremental t)
  (setq evil-ex-search-highlight-all t)
  (setq evil-ex-substitute-highlight-all t)
  (setq evil-ex-substitute-interactive-replace t)
  (setq evil-ex-substitute-global nil) ; global substitute is with s/a/b/g as it should
  (setq evil-command-window-height 7)  ; TODO
  (setq evil-display-shell-error-in-message nil) ; TODO
  (setq evil-undo-system 'undo-redo) ; Emacs 28
  (setq evil-visual-update-x-selection-p t)

;;;; Compatibility with other modes

  ;; I load the `evil' feature here because some functions/macros of
  ;; it are needed from this point on.
  (prot-emacs-package evil (:install t))

  (setq evil-motion-state-modes
        '(completion-list-mode
          Buffer-menu-mode
          Info-mode
          help-mode
          log-view-mode
          org-agenda-mode
          dired-mode
          magit-status-mode
          magit-diff-mode
          magit-log-mode
          notmuch-hello-mode
          notmuch-search-mode
          notmuch-show-mode
          notmuch-tree-mode
          tabulated-list-mode))
  (setq evil-insert-state-modes nil)
  (setq evil-emacs-state-modes
        '(comint-mode
          rcirc-mode
          eshell-mode
          inferior-emacs-lisp-mode
          reb-mode
          shell-mode
          term-mode
          wdired-mode
          log-edit-mode
          git-commit-mode))
  (setq evil-overriding-maps nil)

  (evil-define-state 'prot-basic
    "Basic Vim keys.")
  
  (evil-define-command evil-force-prot-basic-state ()
    "Switch to  state without recording current command."
    :repeat abort
    :suppress-operator t
    (evil-prot-basic-state))

  (evil-define-key 'prot-basic global-map
    (kbd "j") #'evil-next-line
    (kbd "k") #'evil-previous-line
    (kbd "i") #'evil-insert
    (kbd "<escape>") #'evil-force-prot-basic-state)

  (with-eval-after-load 'notmuch
    (evil-define-key 'motion notmuch-hello-mode-map (kbd "J") #'notmuch-jump-search)
    (evil-define-key 'motion notmuch-view-mode-map (kbd "J") #'notmuch-jump-search)
    (evil-define-key 'motion notmuch-search-mode-map (kbd "J") #'notmuch-jump-search)
    (evil-define-key 'motion notmuch-tree-mode-map (kbd "J") #'notmuch-jump-search)
    (evil-define-key 'motion notmuch-view-mode-map (kbd "K") #'notmuch-tag-jump)
    (evil-define-key 'motion notmuch-search-mode-map (kbd "K") #'notmuch-tag-jump)
    (evil-define-key 'motion notmuch-tree-mode-map (kbd "K") #'notmuch-tag-jump))

  (with-eval-after-load 'org-agenda
    (evil-define-key 'motion org-agenda-mode-map (kbd "j") #'evil-next-line)
    (evil-define-key 'motion org-agenda-mode-map (kbd "k") #'evil-previous-line))

;;;; Make Emacs the Insert state

  (defalias 'evil-insert-state 'evil-emacs-state)
  (evil-define-key 'emacs global-map (kbd "<escape>") #'evil-normal-state)
  (setq evil-emacs-state-cursor evil-insert-state-cursor)

;;;; Set up `devil-mode' to reduce modifier key usage

  (prot-emacs-package devil (:install t))

  (evil-define-key '(normal visual motion) global-map (kbd ",") #'devil)

  ;; This one affects the emacs/insert state.
  (global-devil-mode 1)

;;;; Set up my prefix keymap

  (require 'prot-prefix)

  (defun prot/evil-prefix-or-self-insert ()
    "Self-insert key or return `prot-prefix-map'."
    (interactive)
    (if (or buffer-read-only
            (derived-mode-p 'special-mode)
            (memq major-mode evil-motion-state-modes))
        (set-transient-map prot-prefix-map)
      (self-insert-command 1)))

  (evil-define-key '(emacs insert) global-map (kbd "SPC") #'prot/evil-prefix-or-self-insert)
  (evil-define-key '(normal visual motion) global-map (kbd "SPC") prot-prefix-map)

;;;; Activate `evil-mode'
  (evil-mode 1))

(provide 'prot-emacs-evil)
