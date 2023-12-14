_: {
  programs.helix = {
    enable = true;
    settings = {
      # set by stylix
      #theme = "base16_transparent";
      editor = {
        line-number = "relative";
        bufferline = "multiple";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        file-picker.hidden = false;
      };
    };
  };
}
