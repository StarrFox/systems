# https://github.com/remi-gelinas/rosetta/blob/137d6aea578ef023eb8488df9a581a4ae77af21b/packages/gh-poi/default.nix
{
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "gh-poi";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "seachicken";
    repo = "gh-poi";
    rev = "v${version}";
    sha256 = "sha256-7KZSZsYfo9zZ0HSg5yLDNTlwb30byD73kqMNHc0tQpo=";
  };

  # TODO: figure out what this is
  vendorSha256 = "sha256-D/YZLwwGJWCekq9mpfCECzJyJ/xSlg7fC6leJh+e8i0=";
  doCheck = false;
}
