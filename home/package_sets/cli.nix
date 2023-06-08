{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    bat
    cava
    croc
    duf
    drawio
    feh
    ffmpeg
    htop
    httpie
    neofetch
    nethogs
    ncdu
    ripgrep
    rsync
    tldr

    inputs.nh.packages.${pkgs.system}.default
    inputs.nix_search.packages.${pkgs.system}.default

    python3Packages.ipython
    python3Packages.howdoi
  ];
}
