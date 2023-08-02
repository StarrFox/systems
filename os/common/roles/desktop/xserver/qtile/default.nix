{pkgs, ...}: {
  imports = [
    ../common.nix
  ];

  services.xserver.windowManager.qtile = {
    enable = true;
    configFile = ./config.py;
  };

  environment.systemPackages = with pkgs; [
    rofi
    flameshot
  ];
}
