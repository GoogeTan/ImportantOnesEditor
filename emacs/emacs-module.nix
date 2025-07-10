{ config, pkgs, lib, ... }:

let
  types = lib.types;
  mkOption = lib.mkOption;

  cfg = config.emacsConfigUnits;

  # Function to generate the final Emacs configuration string
  generateEmacsConfig = units:
    let
      # Filter out null units and extract configText
      configTexts = lib.map (unit: unit.configText) (lib.filter (unit: unit != null && unit ? "configText") units);
    in
      lib.concatStringsSep "\n" configTexts;

  # Function to collect Emacs packages from all units
  collectEmacsPackages = units:
    let
      emacsPackageGetters = lib.map (unit: unit.emacsPackages) (lib.filter (unit: unit != null && unit ? "emacsPackages") units);
    in
      lib.concatMap (getter: getter pkgs.emacsPackages) emacsPackageGetters;

  # Function to collect Nix packages from all units
  collectNixPackages = units:
    let
      nixPackagesLists = lib.map (unit: unit.nixPackages) (lib.filter (unit: unit != null && unit ? "nixPackages") units);
    in
      lib.unique (lib.flatten nixPackagesLists);

  configUnitType = types.submodule {
    options = {
      nixPackages = mkOption {
        type = types.listOf types.package;
        default = [];
        description = "List of Nix packages required for this Emacs configuration unit.";
      };
      emacsPackages = mkOption {
        type = types.functionTo (types.listOf types.package);
        default = epkgs: [];
        description = "Function that takes emacsPackages and returns a list of Emacs packages.";
      };
      configText = mkOption {
        type = types.lines;
        default = "";
        description = "The Emacs Lisp configuration for this unit.";
      };
    };
  };
in
{
  options = {
    emacsConfigUnits = mkOption {
      type = types.listOf configUnitType;
      default = [];
      description = "A list of Emacs configuration units.";
    };

    emacsConfig = mkOption {
      type = types.attrsOf types.anything;
      default = {};
      description = "A namespace for modular Emacs configuration parts.";
    };
  };

  config = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      extraPackages = epkgs: collectEmacsPackages cfg;
      extraConfig = generateEmacsConfig cfg;
    };

    services.emacs = {
    	enable = true;
    	package = pkgs.emacs;
    };

    home.packages = collectNixPackages cfg;
  };
}
