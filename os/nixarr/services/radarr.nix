{
  inputs,
  config,
  pkgs,
  ...
}: let
  nixpkgs-unstable = import inputs.nixpkgs-unstable {
    system = "${pkgs.stdenv.hostPlatform.system}";
    inherit (config.nixpkgs) config;
  };
in {
  services.radarr = {
    enable = true;
    openFirewall = true;
    group = "arr";
    package = nixpkgs-unstable.radarr;
  };
}
