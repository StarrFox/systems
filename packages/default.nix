{pkgs, ...}: let
  source = import ./_sources/generated.nix {
    fetchurl = pkgs.fetchurl;
    #fetchgit = pkgs.fetchgit;
    fetchFromGitHub = pkgs.fetchFromGitHub;
  };
in {
  gh-poi = pkgs.callPackage ./gh-poi {source = source.gh-poi;};
  imhex = pkgs.callPackage ./imhex {
    source = source.imhex;
    patterns_source = source.imhex-patterns;
  };
  vscord = (pkgs.callPackage ./vscord {source = source.vscord;}).vscord;
}
