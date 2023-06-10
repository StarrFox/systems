{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./services/postgresql.nix
    ./services/ratbagd.nix
    ./services/syncthing.nix
    #./services/nfs.nix

    ../common/services/mullvad.nix
    ../common/services/openssh.nix
    ../common/services/tailscale.nix
    ../common/services/xbanish.nix
    ../common/services/jellyfin.nix

    ../common/nix_daemon.nix
    ../common/timezone.nix
    ../common/locale.nix
    ../common/environment.nix
    ../common/sound.nix
    ../common/flatpak.nix
    ../common/steam.nix
    ../common/firejail.nix

    ../../devices/main.nix

    ../common/users/starr.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        # TODO: change to true eventually
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };

  networking = {
    hostName = "starrnix";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    videoDrivers = ["nvidia"];
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

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  fonts.fonts = with pkgs; [
    # fira-code
    # fira-code-symbols
    (nerdfonts.override {fonts = ["FiraCode"];})
    material-icons
  ];

  age.secrets.test = {
    file = ../../secrets/test.age;
    mode = "400";
    owner = "starr";
  };

  nixpkgs.config.allowUnfree = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      libsForQt5.xdg-desktop-portal-kde
    ];
  };

  system.stateVersion = "23.05";
}
