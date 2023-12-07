_: {
  # NOTE: xserver effects wayland stuff too for some reason
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager = {
      autoLogin = {
        enable = true;
        user = "starr";
      };
      sddm = {
        enable = true;
        autoNumlock = true;
      };
    };
  };
}
