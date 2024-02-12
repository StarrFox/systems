{inputs, ...}: let
  unstable = import inputs.nixpkgs-unstable {};
in {
  services.radarr = {
    enable = true;
    openFirewall = true;
    group = "arr";
    package = unstable.radarr;
  };
}
