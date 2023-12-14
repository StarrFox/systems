{
  lib,
  inputs,
  ...
}: {
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
    };
    # this makes nix * commands use the same nixpkgs versions as the system
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      warn-dirty = false;
      # number of lines shown for failing builds
      log-lines = 25;
      trusted-users = ["@wheel"];
      substituters = [
        "https://starrfox.cachix.org"
      ];
      trusted-public-keys = [
        "starrfox.cachix.org-1:f72kZolyxFrJtrWoLRj12WdEx4xISSOybSlQ21HuhWY="
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;
}
