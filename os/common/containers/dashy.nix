# note: this currently expects a config file in /etc/dashy/dashy_config.yml
_: {
  virtualisation.oci-containers.containers.dashy = {
    image = "lissy93/dashy";
    ports = [
      "8080:80"
    ];
    # TODO: add config module
    volumes = [
      "/etc/dashy/dashy_config.yml:/app/public/conf.yml"
    ];
  };
}
