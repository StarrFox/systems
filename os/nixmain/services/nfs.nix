# https://nixos.wiki/wiki/NFS
_: {
  services.nfs = {
    server = {
      enable = true;
      exports = ''
        /big/media laptop(fsid=root,rw,nohide,insecure,no_subtree_check)
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [2049];
}
