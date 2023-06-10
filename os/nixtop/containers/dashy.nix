_: {
  virtualisation.oci-containers.containers.dashy = {
    image = "lissy93/dashy";
    ports = [
      "8080:80"
    ];
    volumes = [
      "/etc/nixtop/dashy_config.yml:/app/public/conf.yml"
    ];
  };
}
