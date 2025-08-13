{ pkgs, ... }:
let
    helix-mode = pkgs.callPackage ../derivations/helix-mode.nix { };
in {   
    emacsConfig.evilConfig = {
        emacsPackages = epkgs: [ epkgs.evil epkgs.treemacs-evil ];
        configText = ''
            (require 'evil)
            (evil-mode 1)
            (require 'treemacs-evil)
        '';
    };
}
