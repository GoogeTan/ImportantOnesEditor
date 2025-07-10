{ pkgs, ... }:

{
  emacsConfig.sudoReopen = {
	configText = ''
		(defun reopen-file-with-sudo ()
			"Reopen the current file with sudo privileges."
			(interactive)
			(let ((file-name (buffer-file-name)))
		    	(if file-name
		 		(progn
			  		(kill-buffer (current-buffer))
		 	  		(find-file (concat "/sudo::" file-name)))
		      		(message "Buffer is not visiting a file"))))
		
		(global-set-key (kbd "C-x C-!") 'reopen-file-with-sudo)
	'';
   };
}
