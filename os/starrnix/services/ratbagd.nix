{pkgs, ...}: {
  # TODO: figure out how to configure this directly
  # logitech mouse config daemon
  services.ratbagd.enable = true;

  # graphical frontend
  environment.systemPackages = [pkgs.piper];
}
