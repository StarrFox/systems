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
    # this garbage messes up ssh
    shellIntegration = {
      mode = "disabled";
      enableBashIntegration = false;
      enableFishIntegration = false;
      enableZshIntegration = false;
    };
    font = {
      # TODO: should we use font.package to readd this font?
      name = "FiraCode Nerd Font Mono";
      size = 18;
    };
    keybindings = {
      # this is the only reason we dont like alacritty
      # see: https://github.com/alacritty/alacritty/issues/1919#issuecomment-876695473
      "ctrl+c" = "copy_and_clear_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
    };
    # disables the annoying pop-up when you close kitty
    extraConfig = "confirm_os_window_close 0";
  };
}