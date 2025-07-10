{ pkgs, ... }:

{
  emacsConfig.lineNumbersConfig = {
    configText = ''
      (global-display-line-numbers-mode 1)
      (setq display-line-numbers-type 'relative)
      (setq display-line-numbers-width 3)
    '';
  };
}