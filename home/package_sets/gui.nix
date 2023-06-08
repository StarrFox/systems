{
  pkgs,
  starrpkgs,
  ...
}: {
  home.packages = with pkgs; [
    bitwarden
    #chromium
    discord
    flameshot
    gimp
    ghidra-bin
    insomnia # this is the rest api gui thing
    obsidian
    mpv
    the-powder-toy
    thunderbird-bin
    spotify
    virt-manager
    drawio
    feh

    starrpkgs.imhex
  ];
}
