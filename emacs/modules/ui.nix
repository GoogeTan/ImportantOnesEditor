{ pkgs, ... }:

{
  emacsConfig.uiConfig = {
    nixPackages = [];
    emacsPackages = epkgs: [ epkgs.ayu-theme epkgs.rainbow-delimiters epkgs.highlight-indent-guides ];
    configText = ''
      (tool-bar-mode -1)
      (global-tab-line-mode 1)
      (menu-bar-mode -1)
      (scroll-bar-mode -1)
      (load-theme 'ayu-light :no-confirm)
      (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

      '(tab-bar ((t (:background "#f0f0f0" :foreground "#333333"))))
      '(tab-bar-tab ((t (:background "#e0e0e0" :foreground "#000000" :box (:line-width 2 :style released-button)))))
      '(tab-bar-tab-inactive ((t (:background "#d0d0d0" :foreground "#666666" :box (:line-width 2 :style pressed-button)))))

      (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
      (setq highlight-indent-guides-method 'bitmap)
    '';
  };
}
