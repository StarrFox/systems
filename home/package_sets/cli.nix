{
  pkgs,
  inputs,
  ...
}: let
  starrpkgs = inputs.starrpkgs.packages.${pkgs.stdenv.hostPlatform.system};
in {
  home.packages = with pkgs; [
    bat
    cava
    #croc
    duf
    ffmpeg
    htop
    httpie
    #manix
    magic-wormhole
    #neofetch
    #nethogs
    ncdu
    ripgrep
    rsync
    tldr
    just
    #wine

    inputs.nix_search.packages.${pkgs.stdenv.hostPlatform.system}.default

    python3Packages.ipython
    python3Packages.howdoi

    starrpkgs.mrpack-install
  ];
}
