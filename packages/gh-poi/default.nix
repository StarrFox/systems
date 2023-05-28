# https://github.com/remi-gelinas/rosetta/blob/137d6aea578ef023eb8488df9a581a4ae77af21b/packages/gh-poi/default.nix
{
  buildGoModule,
  fetchFromGitHub,
  source
}:
buildGoModule rec {
  inherit (source) pname version src vendorSha256;
  doCheck = false;
}
