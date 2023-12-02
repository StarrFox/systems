_: {
  # TODO: declaritive config file
  # https://search.nixos.org/options?channel=23.11&show=services.sabnzbd.configFile&from=0&size=50&sort=relevance&type=packages&query=services.sabnzbd
  services.sabnzbd = {
    enable = true;
    group = "arr";
  };
}