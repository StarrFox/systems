{
  pkgs,
  inputs,
  ...
}: let
  starrpkgs = inputs.starrpkgs.packages.${pkgs.system};
in {
  home.packages = with pkgs; [
    #bitwarden
    #chromium
    discord
    flameshot
    #gimp
    #ghidra-bin
    #insomnia # this is the rest api gui thing
    obsidian
    lutris
    mpv
    pcsx2
    the-powder-toy
    thunderbird-bin
    spotify
    virt-manager
    #drawio
    feh
    prismlauncher
    #mangohud

    starrpkgs.imhex
  ];
}
