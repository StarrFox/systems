{
  lib,
  pkgs,
  ...
}: let
  ssh-keys = import ../../ssh-keys.nix;
in {
  imports = [
    ../common/services/mullvad.nix
    ../common/services/openssh.nix
    ../common/services/xbanish.nix

    ../common/nix_daemon.nix
    ../common/timezone.nix
    ../common/locale.nix
    ../common/environment.nix
    ../common/uefi_boot.nix
    ../common/network_manager.nix
    ../common/sudo.nix
    ../common/hosts.nix

    ../common/roles/server.nix

    ../../devices/vm.nix

    ../common/users/starr.nix

    ./services/prowlarr.nix
    ./services/radarr.nix
    ./services/transmission.nix
    ./services/sonarr.nix
    #./services/lidarr.nix
    ./services/readarr.nix
    #./services/deluge.nix
    ./services/bazarr.nix
    #./services/flood.nix
    #./services/flaresolverr.nix
  ];

  environment.systemPackages = with pkgs; [
    tremc
  ];

  environment.etc.radarr_sync = {
    source = ./scripts/radarr_sync.py;
    mode = "555";
  };

  networking = {
    hostName = "nixarr";
    useDHCP = lib.mkDefault true;
  };

  # arr services group
  users.groups.arr = {};

  users.users.starr.extraGroups = ["arr"];

  users.users.starr.openssh.authorizedKeys.keys = [
    ssh-keys.starr-nixmain
    ssh-keys.starrwin
  ];

  system.stateVersion = "23.11";
}
