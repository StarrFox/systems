{inputs, pkgs, ...}: {
  # TODO: remove when kitty-themes updates
  nixpkgs.overlays = [
    (final: prev: {
      kitty-themes = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.kitty-themes;
    })
  ];

  programs.kitty = {
    enable = true;
    theme = "Adwaita darker";
    shellIntegration.mode = "disabled";
    font = {
      # TODO: should we use font.package to readd this font?
      name = "FiraCode Nerd Font Mono";
      size = 18;
    };
  };
}