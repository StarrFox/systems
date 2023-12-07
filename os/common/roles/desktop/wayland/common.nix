_: {
  # NOTE: xserver effects wayland stuff too for some reason
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager = {
      # TODO: reenable
      # autoLogin = {
      #   enable = true;
      #   user = "starr";
      # };
      sddm = {
        enable = true;
        autoNumlock = true;
      };
    };
  };
}
