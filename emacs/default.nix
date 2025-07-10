{ pkgs, lib, home-manager, ... }:

let
  # We use home-manager to evaluate the emacs modules, just like in the original config.
  hmConfig = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    # The configuration is passed as a list of modules.
    modules = [
      # We define a dummy user and home directory since we only need the emacs build artifact.
      {
        home.username = "hmacs";
        home.homeDirectory = "/tmp/hmacs";
        home.stateVersion = "24.05"; # Or any recent version.
      }
      # This is the entry point for the emacs configuration modules.
      ./newEmacs.nix
    ];
  };
in
# The final, packaged emacs is available in the generated configuration.
# This is the emacs derivation with all packages and configurations applied by home-manager.
hmConfig.config.programs.emacs.finalPackage
