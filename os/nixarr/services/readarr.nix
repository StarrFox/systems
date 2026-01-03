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
  services.readarr = {
    enable = true;
    openFirewall = true;
    group = "arr";
    package = nixpkgs-unstable.readarr;
  };
}
