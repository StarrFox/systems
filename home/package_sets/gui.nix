{
  pkgs,
  starrpkgs,
  inputs,
  config,
  ...
}: let
  nixpkgs-unstable = import inputs.nixpkgs-unstable {
    system = "${pkgs.system}";
    inherit (config.nixpkgs) config;
  };
in  {
  home.packages = with pkgs; [
    #bitwarden
    #chromium
    discord
    flameshot
    #gimp
    #ghidra-bin
    #insomnia # this is the rest api gui thing
    obsidian
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

    # TODO: see if we still want this
    nixpkgs-unstable.jetbrains.pycharm-community

    starrpkgs.imhex
  ];
}
