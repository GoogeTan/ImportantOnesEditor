{ pkgs, ... }:

{
  emacsConfig.nixSupport = {
    nixPackages = [ pkgs.nil ];
    emacsPackages = epkgs: [ epkgs.nix-mode ];
    configText = ''
      (add-hook 'nix-mode-hook #'lsp)
      (add-hook 'nix-mode-hook #'company-mode)
    '';
  };
}
