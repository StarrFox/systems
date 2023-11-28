_: {
  # TODO: switch to declarative config when we know what settings we want
  # https://search.nixos.org/options?channel=23.05&show=services.deluge.declarative&from=0&size=50&sort=relevance&type=packages&query=deluge
  services.deluge = {
    enable = true;
    group = "arr";
    web = {
      enable = true;
      openFirewall = true;
    };
  };
}