_: {
  networking.networkmanager.enable = true;
  # this service breaks a lot
  systemd.services.NetworkManager-wait-online.enable = false;
}
