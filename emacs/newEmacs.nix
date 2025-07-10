{ pkgs, config, ... }:

{
  imports = [
    ./emacs-module.nix
    ./modules/ui.nix
    ./modules/font.nix
    ./modules/lsp.nix
    ./modules/project.nix
    ./modules/dashboard.nix
    ./modules/treemacs.nix
    ./modules/languages.nix
    ./modules/tools.nix
    ./modules/line-numbers.nix
    ./modules/nix.nix
    ./modules/formatter.nix
    ./modules/evil.nix
  ];

  emacsConfigUnits = with config.emacsConfig; [
    uiConfig
    (fontConfig { family = "Monaspace Neon"; fontPackage = pkgs.monaspace; })
    lspBaseConfig
    (scalaConfig { scalaVersion = "3.7.0"; })
    projectConfig
    dashboardConfig
    treemacsIcons
    sudoReopen
    styleScalaCode
    lineNumbersConfig
    nixSupport
    formatterConfig
    evilConfig
  ];
}
