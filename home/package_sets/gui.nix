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
    pcsx2
    the-powder-toy
    thunderbird-bin
    spotify
    virt-manager
    drawio
    feh
    # TODO: make this always be 6.3 so I have ftb packs (7+ removes them)
    prismlauncher

    starrpkgs.imhex
    # TODO: the unfree garbage hates steam-run
    #starrpkgs.atlauncher
  ];
}
