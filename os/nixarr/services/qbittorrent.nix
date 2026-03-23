{config, ...}: {
  services.qbittorrent = {
    enable = true;
    group = "arr";
    openFirewall = true;
    profileDir = "/media/downloads";
  };

  systemd.tmpfiles.rules = [
    "d /media/downloads 0777 ${config.services.qbittorrent.user} ${config.services.qbittorrent.group} - -"
  ];
}