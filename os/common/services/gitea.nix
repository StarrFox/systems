{config, ...}: {
  # TODO: use postgres for database
  services.gitea = {
    enable = true;
    dump.enable = true;
    server.DOMAIN = config.networking.hostName;
  };
}