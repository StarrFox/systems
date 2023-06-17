_: {
  imports = [
    ../common.nix
  ];

  services.xserver.windowManager.qtile = {
    enable = true;
    configFile = ./config.py;
  };
}