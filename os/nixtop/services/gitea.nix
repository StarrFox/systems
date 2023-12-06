_: {
  # TODO: use postgres for database
  services.gitea = {
    enable = true;
    dump.enable = true;
    settings.server = {
        DOMAIN = "git.nixtop.attlocal.net";
        ROOT_URL = "https://git.nixtop.attlocal.net/";
    };
  };

  services.nginx.virtualHosts."git.nixtop.attlocal.net" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:3000/";
    };
  };
}