{...}: {
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
          family = "Fira Code";
          style = "Regular";
        };
        bold = {
          family = "Fira Code";
          style = "Bold";
        };
        italic = {
          family = "Fira Code";
          style = "Italic";
        };
        size = 16;
        draw_bold_text_with_bright_colors = true;
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
