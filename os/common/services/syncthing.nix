_: {
  # TODO: setup declaritivly
  services.syncthing = {
    enable = true;
    overrideFolders = false;
    overrideDevices = false;
    openDefaultPorts = true;
  };

  # webui port
  networking.firewall.allowedTCPPorts = [8384];
}
