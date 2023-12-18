_: {
  virtualisation.oci-containers.containers.dashy = {
    image = "mauricenino/dashdot";
    ports = [
      "8080:3001"
    ];
    volumes = [
      # os info
      "/etc/os-release:/etc/os-release:ro"
      # network info
      "/proc/1/ns/net:/mnt/host_ns_net:ro"
    ];
  };
}
