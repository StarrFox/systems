{pkgs, ...}: let
  ssh-keys = import ../../ssh-keys.nix;
in {
  imports = [
    ../common/nix_daemon.nix
    ../common/locale.nix
    ../common/timezone.nix
    ../common/uefi_boot.nix
    ../common/environment.nix
    ../common/network_manager.nix
    ../common/sudo.nix
    ../common/hosts.nix

    ../common/services/openssh.nix
    ../common/services/discord_chan.nix
    ../common/services/jellyfin.nix
    #../common/services/tailscale.nix
    ../common/services/nextcloud.nix
    ../common/services/syncthing.nix
    ../common/services/postgresql_backup.nix

    ../common/containers/portainer.nix

    ../common/users/starr.nix

    ../../devices/laptop.nix

    ../common/roles/server.nix

    ./services/nfs.nix
    ./services/nginx.nix
    ./services/gitea.nix
  ];

  users.users.starr.openssh.authorizedKeys.keys = [
    ssh-keys.starr-starrnix
    ssh-keys.starrnix
    ssh-keys.starrwin
    ssh-keys.nixarr
  ];

  networking.hostName = "nixtop";

  # TODO: update
  services.postgresql.package = pkgs.postgresql_14;

  # nixtop is a laptop
  services.logind.lidSwitch = "ignore";

  # NOTE: make sure to double backup postgres before changing
  system.stateVersion = "23.11";
}
