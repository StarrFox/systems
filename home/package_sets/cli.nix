{
  pkgs,
  inputs,
  ...
}: let 
  starrpkgs = inputs.starrpkgs.packages.${pkgs.system};
in {
  home.packages = with pkgs; [
    bat
    cava
    croc
    duf
    ffmpeg
    htop
    httpie
    manix
    magic-wormhole
    #neofetch
    nethogs
    ncdu
    ripgrep
    rsync
    tldr
    just

    inputs.nh.packages.${pkgs.system}.default
    inputs.nix_search.packages.${pkgs.system}.default

    python3Packages.ipython
    python3Packages.howdoi

    starrpkgs.mrpack-install
  ];
}
