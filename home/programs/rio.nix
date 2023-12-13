{inputs, pkgs, ...}: {
  home.packages = [
    # nixpkgs cucks removed builtins.currentSystem
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.rio
  ];

  xdg.configFile."rio/config.toml" = {
    enable = true;
    source = pkgs.writers.writeTOML "config.toml" {
      # rio makes fonts really small for some reason
      fonts.size = 30;
      fonts.family = "FiraCode Nerd Font Mono";
    };
  };
}