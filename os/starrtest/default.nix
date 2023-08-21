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

    ../common/roles/desktop/xserver/plasma.nix

    ../../devices/vm.nix

    ../common/users/starr.nix
  ];

  nix.package = pkgs.nixVersions.unstable;

  networking = {
    hostName = "starrtest";
    useDHCP = lib.mkDefault true;
  };

  fonts.packages = with pkgs; [
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

  users.users.starr.openssh.authorizedKeys.keys = [
    ssh-keys.starr-starrnix
  ];

  system.stateVersion = "23.11";
}
