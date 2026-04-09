{ pkgs, ... }: {
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
    (discord.override {withMoonlight = true;})
    thunderbird-bin


    # games
    # TODO: update when new jdks come out
    # check https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/pr/prismlauncher/package.nix#L37-L42
    (prismlauncher.override {
      jdks = [
        graalvmPackages.graalvm-ce
        javaPackages.compiler.semeru-bin.jre-21
        javaPackages.compiler.semeru-bin.jre-17
        javaPackages.compiler.semeru-bin.jre-8
        jdk25
        jdk21
        jdk17
        jdk8
      ];
    })
    # TODO: prism wants these on path
    mangohud
    gamemode

    heroic
    pcsx2
    the-powder-toy
    lutris
  ];
}
