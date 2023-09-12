_: {
  services.transmission = {
    enable = true;
    openFirewall = true;
    # rpc is the webui
    openRPCPort = true;
    downloadDirPermissions = "777";
    group = "arr";
    settings.rpc-whitelist-enabled = false;
  };
}
