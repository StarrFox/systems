{
  inputs,
  pkgs,
  config,
  ...
}: let
  # TODO: remove this when the version in nixpkgs updates
  nixpkgs-unstable = import inputs.nixpkgs-unstable {
    system = "${pkgs.system}";
    inherit (config.nixpkgs) config;
  };
in {
  # every shell uses this
  programs.starship = {
    enable = true;
    # we need the latest version for the `heuristic` setting
    package = nixpkgs-unstable.starship;
    settings = {
      username.show_always = true;
      nix_shell.heuristic = true;
    };
  };
}
