_: {
  services.nfs-server = {
    enable = true;
    exports = ''
      /nfs 192.168.1.110(rw,fsid=0,no_subtree_check)
    '';
  };

  networking.firewall.allowedTCPPorts = [2049];
}