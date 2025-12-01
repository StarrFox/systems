{
  pkgs,
  inputs,
  ...
}: let
  starrpkgs = inputs.starrpkgs.packages.${pkgs.stdenv.hostPlatform.system};
in {
  home.packages = with pkgs; [
    #bitwarden
    #chromium
    discord
    flameshot
    #gimp
    #ghidra-bin
    obsidian
    lutris
    mpv
    pcsx2
    the-powder-toy
    thunderbird-bin
    spotify
    helvum
    heroic
    virt-manager
    #drawio
    feh
    prismlauncher
    #mangohud

    starrpkgs.imhex
  ];
}
