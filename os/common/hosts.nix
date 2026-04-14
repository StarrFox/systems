{pkgs, ...}: let
  local_ips = import ../../local-ips.nix {inherit (pkgs) lib;};
in {
  networking.hosts = local_ips.as_hosts;
}
