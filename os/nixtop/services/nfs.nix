_: {
  services.nfs.server = {
    enable = true;
    exports = ''
      /nfs starrnix(rw,fsid=0,no_subtree_check)
    '';
  };

  networking.firewall.allowedTCPPorts = [2049];
}