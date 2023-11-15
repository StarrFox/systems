{
  lib,
  pkgs,
  config,
  ...
}: let
  ssh-keys = import ../../ssh-keys.nix;
in {
  imports = [
    ./services/postgresql.nix
    ./services/ratbagd.nix
    ./services/syncthing.nix
    #./services/nfs.nix

    ../common/services/mullvad.nix
    ../common/services/openssh.nix
    #../common/services/tailscale.nix
    ../common/services/xbanish.nix
    ../common/services/jellyfin.nix

    ../common/nix_daemon.nix
    ../common/timezone.nix
    ../common/locale.nix
    ../common/environment.nix
    ../common/sound.nix
    ../common/flatpak.nix
    #../common/steam.nix
    ../common/firejail.nix
    ../common/network_manager.nix
    ../common/docker.nix
    ../common/distrobox.nix

    ../common/roles/desktop/xserver/plasma.nix

    ../../devices/main.nix

    ../common/users/starr.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  users.users.starr.openssh.authorizedKeys.keys = [
    ssh-keys.termux
    ssh-keys.nixarr
  ];

  networking = {
    hostName = "starrnix";
    useDHCP = lib.mkDefault true;
  };

  fileSystems."/nixtop" = {
    device = "nixtop:/nfs";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto" "nfsvers=3"];
  };

  networking.hosts = {
    "192.168.122.214" = ["starrtest"];
    "192.168.122.189" = ["nixarr"];
  };

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  fonts.fonts = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode"];})
    material-icons
  ];

  nixpkgs.config.allowUnfree = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      libsForQt5.xdg-desktop-portal-kde
    ];
  };

  # for obs virtual camera
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];

  system.stateVersion = "23.05";
}
