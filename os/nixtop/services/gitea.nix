_: let
  url = "nixtop.attlocal.net";
in {
  # TODO: use postgres for database
  services.gitea = {
    enable = true;
    dump.enable = true;
    settings.server = {
        DOMAIN = url;
        ROOT_URL = "https://${url}/";
    };
  };

  services.nginx.virtualHosts.${url} = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:3000/";
    };
  };
}