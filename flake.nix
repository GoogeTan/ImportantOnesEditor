{
    description = "A modular Emacs configuration based on Nix";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, flake-utils, home-manager }:
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = import nixpkgs {
                    inherit system;
                    config.allowUnfree = true;
                };
                hmacs = pkgs.callPackage ./emacs { inherit home-manager; };
            in {
                packages.default = hmacs;

                apps.default = {
                    type = "app";
                    program = "${hmacs}/bin/emacs";
                };
            }
        );
}
