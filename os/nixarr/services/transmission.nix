{pkgs, ...}: {
  # TODO: figure out how to access the webui externally
  services.transmission = {
    enable = true;
    openFirewall = true;
    # rpc is the webui
    openRPCPort = true;
    downloadDirPermissions = "777";
    group = "arr";

    package = pkgs.transmission_4;

    settings = {
      rpc-whitelist-enabled = false;
      rpc-host-whitelist-enabled = false;
      rpc-bind-address = "0.0.0.0";
      rpc-username = "starr";
      rpc-whitelist = "127.0.0.1,::1,192.168.1.71";
      #rpc-host-whitelist = "starrnix";
    };
  };
}
