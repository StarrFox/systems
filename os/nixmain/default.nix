{
  lib,
  config,
  ...
}: let
  ssh-keys = import ../../ssh-keys.nix;
in {
  # please change name :)
  imports = [
    ./services/postgresql.nix
    #./services/ratbagd.nix
    ./services/syncthing.nix
    #./services/nfs.nix
    #./services/openlinkhub.nix

    ../common/services/mullvad.nix
    ../common/services/openssh.nix
    #../common/services/tailscale.nix
    ../common/services/xbanish.nix
    #../common/services/jellyfin.nix
    #../common/services/jellyseerr.nix
    ../common/services/locate.nix

    ../common/nix_daemon.nix
    ../common/timezone.nix
    ../common/locale.nix
    ../common/environment.nix
    ../common/sound.nix
    ../common/flatpak.nix
    #../common/steam.nix
    ../common/firejail.nix
    ../common/network_manager.nix
    ../common/fonts.nix
    ../common/sudo.nix
    ../common/hosts.nix
    ../common/bluetooth.nix
    ../common/nix_ld.nix # for uv

    ../common/roles/desktop/xserver/plasma.nix
    #../common/roles/desktop/wayland/hyperland.nix

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
    ssh-keys.nixarr
  ];

  networking = {
    hostName = "nixmain";
    useDHCP = lib.mkDefault true;
  };

  #fileSystems."/nixtop" = {
  #  device = "nixtop:/nfs";
  #  fsType = "nfs";
  #  options = ["x-systemd.automount" "noauto" "nfsvers=3"];
  #};

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # for obs virtual camera
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];

  system.stateVersion = "25.11";
}
