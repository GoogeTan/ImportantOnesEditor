{ pkgs, ... }:
{
  emacsConfig.fontConfig = { family, fontPackage }: {
    nixPackages = [ fontPackage ];
    emacsPackages = epkgs: [];
    configText = "(set-face-attribute 'default nil :family \"${family}\")";
  };
}
