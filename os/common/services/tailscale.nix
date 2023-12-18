{config, ...}: {
  # TODO: set authKeyFile
  # it's in tailscale settings to get one
  services.tailscale.enable = true;

  # trust tailscale interface
  networking.firewall.trustedInterfaces = [config.services.tailscale.interfaceName];
  networking.firewall.allowedUDPPorts = [config.services.tailscale.port];
}
