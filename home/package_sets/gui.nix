{
  pkgs,
  inputs,
  ...
}: let
  starrpkgs = inputs.starrpkgs.packages.${pkgs.stdenv.hostPlatform.system};
in {
  home.packages = with pkgs; [
    # productivity
    #bitwarden
    #chromium
    ghidra-bin
    obsidian
    virt-manager


    # media
    mpv
    spotify
    feh
    helvum
    flameshot


    # messaging
    element-desktop
    discord
    thunderbird-bin


    # games
    xivlauncher
    prismlauncher
    #mangohud
    heroic
    pcsx2
    the-powder-toy
    lutris


    starrpkgs.imhex
  ];
}
