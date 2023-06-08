# this is just for testing
{pkgs, ...}: {
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.xserver = {
    enable = true;
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
    desktopManager.plasma5.enable = true;
  };

  environment.systemPackages = with pkgs; [
    firefox
  ];
}
