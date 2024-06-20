_: {
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager = {
      # autoLogin = {
      #   enable = true;
      #   user = "starr";
      # };
      sddm = {
        enable = true;
        autoNumlock = true;
      };
  };
}
