_: {
  imports = [
    ./common.nix
  ];

  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    # electron app support
    NIXOS_OZONE_WL = "1";

    # NOTE: these two can apparently cause issues
    #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
  };
}
