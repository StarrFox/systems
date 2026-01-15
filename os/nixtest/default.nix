{
  lib,
  pkgs,
  ...
}: let
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
    ../common/network_manager.nix
    ../common/fonts.nix
    ../common/sudo.nix
    ../common/hosts.nix

    ../common/roles/desktop/xserver/plasma.nix

    ../../devices/nixtest.nix

    ../common/users/starr.nix
  ];

  nix.package = pkgs.nixVersions.latest;

  networking = {
    hostName = "nixtest";
    useDHCP = lib.mkDefault true;
  };

  users.users.starr.openssh.authorizedKeys.keys = [
    ssh-keys.starr-starrnix
  ];

  system.stateVersion = "25.11";
}
