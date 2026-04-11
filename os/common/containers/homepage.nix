_: {
  imports = [
    ./docker.nix
  ];

  virtualisation.oci-containers.containers.homepage = {
    image = "ghcr.io/gethomepage/homepage:latest";
    autoStart = true;

    ports = [
      "9582:3000"
    ];

    volumes = [
      "/var/lib/homepage/config:/app/config"
      "/var/run/docker.sock:/var/run/docker.sock"
    ];

    environment = {
      # TODO: set to * when behind reverse proxy
      # https://gethomepage.dev/installation/#homepage_allowed_hosts
      HOMEPAGE_ALLOWED_HOSTS = "nixcell:9582";
    };
  };

    systemd.tmpfiles.rules = [
    "d /var/lib/homepage 0755 root root -"
    "d /var/lib/homepage/config 0755 root root -"
  ];

  networking.firewall.allowedTCPPorts = [ 9582 ];
}