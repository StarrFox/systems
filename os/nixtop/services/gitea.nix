_: let
  url = "nixtop.attlocal.net";
  https = false;
in {
  # TODO: use postgres for database
  services.gitea = {
    enable = true;
    dump.enable = true;
    settings.server = {
      DOMAIN = url;
      ROOT_URL = "http${
        if https
        then "s"
        else ""
      }://${url}/";
    };
  };

  services.nginx.virtualHosts.${url} = {
    enableACME = https;
    forceSSL = https;
    locations."/" = {
      proxyPass = "http://localhost:3000/";
    };
  };
}
