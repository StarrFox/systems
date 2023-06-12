# most of this is from https://github.com/numtide/srvos/blob/5db34b8c369dad476406ef8ac6382fd019bd07a3/nixos/server/default.nix
{lib, ...}: {
  # Notice this also disables --help for some commands such es nixos-rebuild
  documentation.enable = lib.mkDefault false;
  documentation.info.enable = lib.mkDefault false;
  documentation.man.enable = lib.mkDefault false;
  documentation.nixos.enable = lib.mkDefault false;

  # No need for these on a server
  fonts.fontconfig.enable = lib.mkDefault false;
  sound.enable = false;

  # Print the URL instead on servers
  environment.variables.BROWSER = "echo";

  networking.firewall.enable = true;

  users.mutableUsers = false;

  # TODO: what does this actually do?
  # use TCP BBR has significantly increased throughput and reduced latency for connections
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
}