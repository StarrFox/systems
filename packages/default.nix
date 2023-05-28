{pkgs, ...}:
let
  source = import ./_sources/generated.nix {
    fetchurl = pkgs.fetchurl;
    fetchgit = pkgs.fetchgit;
    fetchFromGitHub = pkgs.fetchFromGitHub;
  };
in
{
  gh-poi = pkgs.callPackage ./gh-poi {source = source.gh-poi;};
  # TODO: fix
  #imhex = pkgs.callPackage ./imhex {source = source.imhex;};
}
