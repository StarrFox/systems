_: {
  services.nfs.server = {
    enable = true;
    exports = ''
      /nfs 192.168.1.71(rw,fsid=0,no_subtree_check)
    '';
    statdPort = 4000;
    lockdPort = 4001;
    mountdPort = 4002;
    createMountPoints = true;
  };

  networking.firewall.allowedTCPPorts = [111 2049 4000 4001 4002];
}
