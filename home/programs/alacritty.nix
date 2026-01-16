_: {
  programs.alacritty = {
    enable = true;
    # https://github.com/alacritty/alacritty/blob/master/alacritty.yml
    settings = {
      window = {
        opacity = 1.0;
        dynamic_title = true;
      };
      font = {
        normal = {
          family = "FiraCode Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font Mono";
          style = "Italic";
        };
        size = 16;
      };
      colors = {
        primary = {
          background = "#000000";
          # text color
          foreground = "#FFFFFF";
        };
      };
    };
  };
}
