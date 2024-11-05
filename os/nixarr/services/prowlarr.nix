{inputs, config, pkgs, ...}:
let
  nixpkgs-unstable = import inputs.nixpkgs-unstable {
    system = "${pkgs.system}";
    inherit (config.nixpkgs) config;
  };
in

{
  services.prowlarr = {
    enable = true;
    openFirewall = true;
    package = nixpkgs-unstable.prowlarr;
  };
}
