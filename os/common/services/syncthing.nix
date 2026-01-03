_: {
  # TODO: setup declaritivly
  services.syncthing = {
    enable = true;
    overrideFolders = false;
    overrideDevices = false;
    openDefaultPorts = true;
    # this allows remote accessing the webui
    # https://docs.syncthing.net/users/firewall.html#remote-web-gui
    guiAddress = "0.0.0.0:8384";
  };

  # webui port
  networking.firewall.allowedTCPPorts = [8384];
}
