{
  pkgs,
  starrpkgs,
  ...
}: {
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
    jetbrains.pycharm-community

    starrpkgs.imhex
  ];
}
