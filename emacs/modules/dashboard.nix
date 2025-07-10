{ pkgs, ... }:

{
  emacsConfig.dashboardConfig = {
    emacsPackages = epkgs: [ epkgs.dashboard ];
    configText = let
          logoPath = ../icon/logo.svg;
    in ''
      (require 'dashboard)
      (dashboard-setup-startup-hook)
      (setq dashboard-projects-backend 'projectile)
      (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
      (setq dashboard-items '((recents   . 5)
                        (bookmarks . 5)
                        (projects  . 5)
                        (agenda    . 5)
                        (registers . 5)))
      (setq dashboard-startup-banner "${logoPath}")
    '';
  };
}
