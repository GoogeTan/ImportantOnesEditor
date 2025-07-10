{ pkgs, ... }:

{
  emacsConfig.projectConfig = {
    nixPackages = [pkgs.librsvg];
    emacsPackages = epkgs: [ epkgs.projectile epkgs.treemacs epkgs.treemacs-projectile ];
    configText =''
      (projectile-mode +1)
      (require 'treemacs)
      (require 'treemacs-projectile)

      (global-set-key (kbd "C-x t t") 'treemacs)
      (setq treemacs-is-never-other-window t)
      (setq treemacs-width 35)
      (setq treemacs-follow-mode t)
      (setq treemacs-filewatch-mode t)
      (setq treemacs-project-follow-mode t)
      (add-hook 'projectile-after-switch-project-hook #'treemacs)
      (add-hook 'find-file-hook #'treemacs-add-and-display-current-project)
    '';
  };
}
