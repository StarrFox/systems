{config, ...}: {
  services.tailscale.enable = true;

  # trust tailscale interface
  networking.firewall.trustedInterfaces = [config.services.tailscale.interfaceName];
  networking.firewall.allowedUDPPorts = [config.services.tailscale.port];
}
