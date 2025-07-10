{ pkgs, ... }:

{
  emacsConfig.scalaConfig = { scalaVersion }: {
    nixPackages = [ pkgs.sbt pkgs.metals ];
    emacsPackages = epkgs: [ epkgs.scala-mode epkgs.lsp-metals epkgs.sbt-mode ];
    configText = ''
      (require 'lsp-metals)
      (setq lsp-metals-server-command "${pkgs.metals}/bin/metals-emacs")
      (setq lsp-metals-scala-version "${scalaVersion}")
      (require 'sbt-mode)
      (add-hook 'sbt-mode-hook #'company-mode)
      (add-hook 'scala-mode-hook #'lsp)
      (add-hook 'scala-mode-hook #'company-mode)
    '';
  };

  emacsConfig.styleScalaCode = {
	nixPackages = [
	       pkgs.nerd-fonts.monaspace
	    ];
	emacsPackages = epkgs: [
	       epkgs.treesit-grammars.with-all-grammars
	       epkgs.scala-ts-mode 	      
	       ];
	configText = ''
      ;; Ensure font-lock-mode is enabled
    (global-font-lock-mode 1)
    ;; Define function to set faces with OpenType features
    (defun set-face-with-otf (face family foreground height &optional weight)
      (set-face-attribute face nil
                          :font (font-spec :family family :otf '(calt))))
                          
			  
    ;; Set faces for syntax highlighting
    (let ((bg-dark "#1e1e2e")
          (fg-light "#cdd6f4")
          (accent-blue "#89b4fa")
          (accent-green "#a6e3a1")
          (accent-red "#f38ba8")
          (accent-yellow "#f9e2af")
          (bg-secondary "#313244")
          (fg-comment "#6c7086"))
      (set-face-with-otf 'font-lock-comment-face "Monaspace Radon" fg-comment 120)
      (set-face-with-otf 'font-lock-string-face "Monaspace Radon" accent-green 120 'medium)
      (set-face-with-otf 'font-lock-keyword-face "Monaspace Argon" accent-blue 120 'bold)
      (set-face-with-otf 'font-lock-type-face "Monaspace Krypton" accent-blue 120)
      (set-face-with-otf 'font-lock-variable-name-face "Monaspace Neon" fg-light 120 'demibold)
      (set-face-with-otf 'font-lock-function-name-face "Monaspace Neon" accent-yellow 120)
      (set-face-with-otf 'font-lock-constant-face "Monaspace Xenon" accent-red 120)
      ;;(set-face-with-otf 'scala-font-lock:var-face "Monaspace Xenon" accent-red 120)
      ;; Additional face customizations
      (set-face-attribute 'font-lock-builtin-face nil :foreground accent-blue :weight 'bold)
      (set-face-attribute 'font-lock-comment-delimiter-face nil :foreground fg-comment :slant 'italic)
      (set-face-attribute 'font-lock-doc-face nil :foreground fg-comment :slant 'italic)
      (set-face-attribute 'font-lock-negation-char-face nil :foreground accent-red :weight 'bold)
      (set-face-attribute 'font-lock-preprocessor-face nil :foreground accent-blue)
      (set-face-attribute 'font-lock-regexp-grouping-backslash nil :foreground accent-yellow)
      (set-face-attribute 'font-lock-regexp-grouping-construct nil :foreground accent-yellow)
      (set-face-attribute 'font-lock-warning-face nil :foreground accent-yellow :weight 'bold))
    ;; Apply to scala-mode and scala-ts-mode
    (add-hook 'scala-mode-hook
              (lambda ()
                (set-face-with-otf 'font-lock-comment-face "Monaspace Radon" "#C7C7CC" 120)
                (set-face-with-otf 'font-lock-string-face "Monaspace Radon" "#28CD41" 120 'medium)
                (set-face-with-otf 'font-lock-keyword-face "Monaspace Argon" "#2C2C2E" 120)))
    (add-hook 'scala-ts-mode-hook
              (lambda ()
                (set-face-with-otf 'font-lock-comment-face "Monaspace Radon" "#C7C7CC" 120)
                (set-face-with-otf 'font-lock-string-face "Monaspace Radon" "#28CD41" 120 'medium)
                (set-face-with-otf 'font-lock-keyword-face "Monaspace Argon" "#2C2C2E" 120)))
    ;; Set background
    ;;(set-background-color "#F2F2F7")
      '';
   };
}
