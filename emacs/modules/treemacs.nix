{ pkgs, ... }:

{
  emacsConfig.treemacsIcons = {
    nixPackages = [pkgs.librsvg];
    emacsPackages = epkgs: [ epkgs.treemacs ];
    configText =  let
    	       # Path to the icons directory
  	       iconsDir = ../icon;
  	       folderIcon = "${iconsDir}/folder/folder.svg";
  	       scalaIcon = "${iconsDir}/scala/scala.svg";
  	       vscIcon = "${iconsDir}/vcs/vcs.svg";
  	       workspaceIcon = "${iconsDir}/workspace/workspace.svg";
  	       homeFolderIcon = "${iconsDir}/homeFolder/homeFolder.svg";
  	       moduleIcon = "${iconsDir}/module/module.svg";
  	       jsonIcon = "${iconsDir}/json/json.svg";
  	       sbtIcon = "${iconsDir}/config/config.svg";
  	       targetIcon = "${iconsDir}/excludeRoot/excludeRoot.svg";
  	       sourceIcon = "${iconsDir}/source/source.svg";
      in ''
        (require 'treemacs)
	(treemacs-resize-icons 16)
	(treemacs-modify-theme "Default"
	  :icon-directory "${toString iconsDir}"
	  :config
	  (progn
	    (treemacs-create-icon :file "${folderIcon}" :extensions (dir-closed))
	    (treemacs-create-icon :file "${folderIcon}" :extensions (dir-open))

	    (treemacs-create-icon :file "${moduleIcon}" :extensions ("src-open"))
	    (treemacs-create-icon :file "${moduleIcon}" :extensions ("src-closed"))
	    
	    (treemacs-create-icon :file "${workspaceIcon}" :extensions (root-closed))
	    (treemacs-create-icon :file "${workspaceIcon}" :extensions (root-open))

	    (treemacs-create-icon :file "${scalaIcon}" :extensions ("scala"))
	    (treemacs-create-icon :file "${sbtIcon}" :extensions ("sbt"))
	    (treemacs-create-icon :file "${jsonIcon}" :extensions ("json"))

	    (treemacs-create-icon :file "${vscIcon}" :extensions ("gitignore"))
	    (treemacs-create-icon :file "${vscIcon}" :extensions (".github"))
	    (treemacs-create-icon :file "${vscIcon}" :extensions ("github-open"))
	    (treemacs-create-icon :file "${vscIcon}" :extensions ("github-closed"))

	    (treemacs-create-icon :file "${targetIcon}" :extensions ("target-open"))
	    (treemacs-create-icon :file "${targetIcon}" :extensions ("target-closed"))

	    (treemacs-create-icon :file "${sourceIcon}" :extensions ("source-open"))
	    (treemacs-create-icon :file "${sourceIcon}" :extensions ("source-closed"))

		)
	
	)
'';
  };
}
