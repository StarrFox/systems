_: {
  imports = [
    ./docker.nix
  ];

  virtualisation.oci-containers.containers.discopanel = {
    image = "nickheyer/discopanel:latest";
    autoStart = true;

    network = "host";

    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/var/lib/discopanel/data:/app/data"
      "/var/lib/discopanel/backups:/app/backups"
      "/tmp/discopanel:/app/tmp"
    ];

    environment = {
      DISCOPANEL_DATA_DIR = "/app/data";
      DISCOPANEL_HOST_DATA_PATH = "/var/lib/discopanel/data";
      TZ = "UTC";
    };

    extraOptions = [
      "--add-host=host.docker.internal:host-gateway"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/discopanel 0755 root root -"
    "d /var/lib/discopanel/data 0755 root root -"
    "d /var/lib/discopanel/backups 0755 root root -"
  ];

  networking.firewall.allowedTCPPorts = [ 8080 25565 ];
  networking.firewall.allowedUDPPorts = [ 25565 ];
}