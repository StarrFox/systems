{lib, ...}: let
  ssh-keys = import ../../ssh-keys.nix;
in {
  imports = [
    ../common/services/openssh.nix
    ../common/services/xbanish.nix

    ../common/nix_daemon.nix
    ../common/timezone.nix
    ../common/locale.nix
    ../common/environment.nix
    ../common/sound.nix
    ../common/firejail.nix
    ../common/uefi_boot.nix

    ../common/roles/desktop/xserver/plasma.nix

    ../../devices/vm.nix

    ../common/users/starr.nix
  ];

  networking = {
    hostName = "starrtest";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  nixpkgs.config.allowUnfree = true;

  xdg.portal.enable = true;

  users.users.starr.openssh.authorizedKeys.keys = [
    ssh-keys.starr-starrnix
  ];

  system.stateVersion = "23.05";
}
