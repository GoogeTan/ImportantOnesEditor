{ pkgs, ... }:

{
  emacsConfig.uiConfig = {
    nixPackages = [];
    emacsPackages = epkgs: [ epkgs.ayu-theme epkgs.rainbow-delimiters epkgs.highlight-indent-guides ];
    configText = ''
      (tool-bar-mode -1)
      (menu-bar-mode -1)
      (scroll-bar-mode -1)
      (load-theme 'ayu-light :no-confirm)
      (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
      (add-hook 'prog-mode-hook #'highlight-indent-guides-mode)

      (setq tab-bar-show t)              
      (setq tab-bar-new-tab-choice "*scratch*") ; Default new tab buffer
      (setq tab-bar-tab-hints t)         ; Show numbers for quick tab switching
      (setq tab-bar-auto-width nil)      ; Fixed-width tabs for consistency
      (setq tab-bar-format '(tab-bar-format-tabs)) ; Show only tabs, no extra buttons

      (defun my-tab-bar-buffer-p (buffer)
             "Return t if BUFFER is a file-associated buffer."
             (with-current-buffer buffer
                 (and buffer-file-name
                 (not (string-match-p "\\`\\*.*\\*\\'" (buffer-name))))))

      (setq tab-bar-select-tab-modifiers '(meta))
      (setq tab-bar-tab-name-function
      (lambda () (buffer-name (window-buffer (selected-window)))))
      (setq tab-bar-tab-name-ellipsis "...") ; Truncate long names
      (add-to-list 'tab-bar-format 'tab-bar-format-align-right t)
      (setq tab-bar-buffer-predicate 'my-tab-bar-buffer-p)

      (defun my-tab-bar-theme ()
             "Set tab bar faces to match the current theme."
      (let ((bg (face-attribute 'default :background))
        (fg (face-attribute 'default :foreground))
        (mode-line-bg (face-attribute 'mode-line :background))
        (mode-line-fg (face-attribute 'mode-line :foreground)))
        (custom-set-faces
          `(tab-bar ((t (:background ,bg :foreground ,fg :box (:line-width 1 :style released-button)))))
          `(tab-bar-tab ((t (:background ,mode-line-bg :foreground ,mode-line-fg :weight bold))))
          `(tab-bar-tab-inactive ((t (:background ,bg :foreground ,fg)))))))

      ;; Apply theme on startup and when changing themes
      (add-hook 'after-init-hook 'my-tab-bar-theme)
      (add-hook 'enable-theme-functions 'my-tab-bar-theme)
    '';
  };
}
