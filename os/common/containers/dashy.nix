_: {
  virtualisation.oci-containers.containers.dashy = {
    image = "lissy93/dashy";
    ports = [
      "8080:80"
    ];
    # TODO: add config module
    volumes = [
      "/home/starr/dashy_config.yml:/app/public/conf.yml"
    ];
  };
}
