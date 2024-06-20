_: {
  imports = [
    ./common.nix
  ];

  services.desktopManager.plasma6.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;
}
