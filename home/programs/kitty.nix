_: {
  programs.kitty = {
    enable = true;
    theme = "Adwaita darker";
    font = {
      # TODO: should we use font.package to readd this font?
      name = "FiraCode Nerd Font Mono";
      size = 18;
    };
  };
}