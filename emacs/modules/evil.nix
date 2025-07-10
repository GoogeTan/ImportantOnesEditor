{ pkgs, ... }:
let 
	helix-mode = pkgs.callPackage ../derivations/helix-mode.nix { };
in {   
   emacsConfig.evilConfig = {                                                                      
     emacsPackages = epkgs: [ helix-mode ];  
     configText = ''       
	(require 'helix)
	(helix-mode)
     ''; 
   };
}
