{
  config,
  lib,
  ...
}: {
  services.grafana = {
    enable = true;
    settings = {
      server = {
        domain = "nixtop.tail0a23c.ts.net";
        http_addr = "127.0.0.1";
        root_url = lib.mkForce "http://nixtop.tail0a23c.ts.net/grafana/";
      };
    };
  };

  services.nginx.virtualHosts.${config.services.grafana.settings.server.domain} = {
    locations."/grafana/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.grafana.settings.server.http_port}/";
      proxyWebsockets = true;
    };
  };

  networking.firewall.allowedTCPPorts = [config.services.grafana.settings.server.http_port];
  networking.firewall.allowedUDPPorts = [config.services.grafana.settings.server.http_port];
}
