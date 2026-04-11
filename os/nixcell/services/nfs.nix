# https://wiki.nixos.org/wiki/NFS
{pkgs, ...}: let
  local_ips = import ../../../local-ips.nix {lib = pkgs.lib;};
in {
  services.nfs = {
    server = {
      enable = true;
      exports = ''
        /export/media ${local_ips.ips.nixmain}(fsid=root,rw,nohide,insecure,no_subtree_check)
      '';
    };
  };

  fileSystems = {
    "/export/media" = {
      device = "/big/media";
      options = ["bind"];
    };
  };

  networking.firewall.allowedTCPPorts = [2049];
}
