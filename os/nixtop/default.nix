{...}: {
  imports = [
    ../common/nix_daemon.nix
    ../common/locale.nix
    ../common/timezone.nix
    ../common/uefi_boot.nix
    ../common/environment.nix

    ../common/containers/dashy.nix

    ../common/services/openssh.nix
    ../common/services/discord_chan.nix
    #../common/services/cockpit.nix

    ../common/users/starr.nix

    # to make testing nixtop easier
    #./services/xorg.nix

    ../../devices/laptop.nix
  ];

  networking.hostName = "nixtop";
  networking.networkmanager.enable = true;

  # nixtop is a laptop
  services.logind.lidSwitch = "ignore";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.05";
}
