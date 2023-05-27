{pkgs, ...}:
{
  services.mullvad-vpn = {
    enable = true;
    # the gui application instead of just the cli
    package = pkgs.mullvad-vpn;
  };
}