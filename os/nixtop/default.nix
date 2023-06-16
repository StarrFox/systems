_: let
  ssh-keys = import ../../ssh-keys.nix;
in {
  imports = [
    ../common/nix_daemon.nix
    ../common/locale.nix
    ../common/timezone.nix
    ../common/uefi_boot.nix
    ../common/environment.nix

    ../common/containers/dashy.nix

    ../common/services/openssh.nix
    ../common/services/discord_chan.nix
    ../common/services/arcanumbot.nix
    ../common/services/jellyfin.nix
    ../common/services/grafana.nix
    ../common/services/tailscale.nix
    # TODO: readd when more stable
    #../common/services/attic.nix
    ../common/services/nginx.nix

    ../common/users/starr.nix

    ../../devices/laptop.nix

    ../common/roles/server.nix
  ];

  users.users.starr.openssh.authorizedKeys.keys = [
    ssh-keys.starr-starrnix
  ];

  environment.etc."dashy/dashy_config.yml" = {
    # full access to all users
    mode = "777";
    source = ./config_files/dashy_config.yml;
  };

  networking.hostName = "nixtop";
  networking.networkmanager.enable = true;

  # nixtop is a laptop
  services.logind.lidSwitch = "ignore";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";
}
