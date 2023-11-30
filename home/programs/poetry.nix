{pkgs, inputs, config, ...}: let
  nixpkgs-unstable = import inputs.nixpkgs-unstable {
    system = "${pkgs.system}";
    inherit (config.nixpkgs) config;
  };
in {
  # TODO: 23.11 unstable no longer needed
  xdg.configFile."pypoetry/config.toml" = {
    enable = true;
    source = nixpkgs-unstable.writers.writeTOML "config.toml" {
      virtualenvs.in-project = true;
    };
  };
}