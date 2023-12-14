{pkgs, config, ...}: let
  nixos-artwork = pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixos-artwork";
    rev = "master";
    hash = "sha256-QZrC1cSNThvQJymM7rRVXxpZ+rY+vOVm17P6vVVB6WM=";
  };

  ninish-dark-gray = derivation {
    name = "ninish-dark-gray-wallpaper";
    system = pkgs.system;
    builder = "${pkgs.bash}/bin/bash";
    args = [
      "-c"
      "cp ${nixos-artwork}/wallpapers/nix-wallpaper-nineish-dark-gray.png $out"
    ];
    PATH = "${pkgs.coreutils}/bin/";
  };
in {
  stylix = {
    image = ./nix-wallpaper-nineish-dark-gray.png;
    polarity = "dark";
    fonts = {
      sizes = {
        applications = 18;
      };

      monospace = {
        package = (pkgs.nerdfonts.override {fonts = ["FiraCode"];});
        name = "FiraCode Nerd Font Mono";
      };

      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
    };
  };
}