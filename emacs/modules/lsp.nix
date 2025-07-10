{ pkgs, ... }:

{
  emacsConfig.lspBaseConfig = {
    nixPackages = [];
    emacsPackages = epkgs: [ epkgs.lsp-mode epkgs.lsp-ui epkgs.company ];
    configText = ''
      (require 'lsp-mode)
      (require 'lsp-ui)
      (setq lsp-ui-sideline-enable t
            lsp-ui-doc-enable t)
      (require 'company)
      (setq gc-cons-threshold 100000000)
      (setq lsp-idle-delay 0.500)
      (setq company-minimum-prefix-length 1
            company-idle-delay 0.0)
    '';
  };

  emacsConfig.languageLspConfig = { mode, nixPackages } : {
    nixPackages = nixPackages;
    emacsPackages = epkgs: [];
    configText = ''
      (add-hook '${mode}-mode-hook #'lsp)
      (add-hook '${mode}-mode-hook #'company-mode)
    '';
  };
}
