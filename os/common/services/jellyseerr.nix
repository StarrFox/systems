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
  services.jellyseerr = {
    enable = true;
    openFirewall = true;
    package = nixpkgs-unstable.jellyseerr;
  };
}
