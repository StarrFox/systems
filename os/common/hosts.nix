{pkgs, ...}: let
  local_ips = import ../../local-ips.nix {lib = pkgs.lib;};
in {
  networking.hosts = local_ips.as_hosts;
}
