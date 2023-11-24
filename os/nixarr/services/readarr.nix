{inputs, pkgs, config, ...}: let
  nixpkgs-unstable = import inputs.nixpkgs-unstable {
    system = "${pkgs.system}";
    inherit (config.nixpkgs) config;
  };
in {
  services.readarr = {
    enable = true;
    openFirewall = true;
    group = "arr";
    # TODO: 23.11 switch to stable
    package = nixpkgs-unstable.readarr;
  };
}
