{pkgs, ...}: {
  gh-poi = pkgs.callPackage ./gh-poi {};
  imhex = pkgs.callPackage ./imhex {};
}
