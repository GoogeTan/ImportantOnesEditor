{ pkgs, lib, stdenv, fetchFromGitHub, emacs }:

let
  version = "0.1.0";  # Replace with the actual version from the repository
in
pkgs.emacsPackages.trivialBuild {
  pname = "helix-mode";
  inherit version;
  src = fetchFromGitHub {
    owner = "mgmarlow";
    repo = "helix-mode";
    rev = "v${version}";  # Or use the commit hash
    sha256 = "sha256-6KGxhDY+tvAoYy4ifizNeZhqEqO6/j/0HAlBlklA4Gg=";  # Run nix-build to get the correct sha256
  };
  meta = with lib; {
    description = "Helix keybindings in Emacs";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}
