{config, ...}: {
  services.grafana = {
    enable = true;
    settings = {};
    # settings = {
    #   server = {
    #     domain = "";
    #   };
    # };
  };

  networking.firewall.allowedTCPPorts = [config.services.grafana.settings.server.http_port];
  networking.firewall.allowedUDPPorts = [config.services.grafana.settings.server.http_port];
}