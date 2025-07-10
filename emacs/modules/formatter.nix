{ pkgs, ... }:
{
   emacsConfig.formatterConfig = {
     nixPackages = with pkgs; [
     	nixpkgs-fmt
     	scalafmt
     ];
     emacsPackages = epkgs: [ epkgs.apheleia ];
     configText = ''
       (require 'apheleia)

       (setf (alist-get 'nix-mode apheleia-formatters) '(nixpkgs-fmt))
       (setf (alist-get 'scala-mode apheleia-formatters) '(scalafmt))

       ;; This enables the formatter to run automatically on-save in any
       ;; buffer that has a configured formatter.
       (apheleia-global-mode +1)
     '';
   };
}
