{ pkgs, ... }:
let 
	helixMotionsPackage = pkgs.emacs30.pkgs.trivialBuild {
	  pname = "helix-mode";
	  version = "0.7.0";
	  src = pkgs.fetchFromGitHub {
	    owner = "mgmarlow";
	    repo = "helix-mode";
	    rev = "v0.7.0";
	    sha256 = "0n6zpn8b902xfk98fxqk0mh1n187qsgp3fk3zv6p0c9v8gqycaiz";
	  };
	  meta = with pkgs.lib; {
	    description = "Helix keybindings in Emacs";
	    license = licenses.mit;
	    homepage = "https://github.com/mgmarlow/helix-mode";
	  };
	};
in {
	emacsConfig.helixMotions = {
		nixPackages = [ helixMotionsPackage ];
		configText = ''
			(require 'helix-mode)
			(helix-global-mode 1)
		'';
	};
}

