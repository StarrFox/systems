_: {
  services.rustdesk-server = {
    enable = true;
    openFirewall = true;
    signal.enable = true;
    relay.enable = true;
  };
}