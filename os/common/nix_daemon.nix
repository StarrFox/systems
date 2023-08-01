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
      trusted-users = ["@wheel"];
      substituters = [
        "https://starrfox.cachix.org"
        "http://nixtop:5000"
      ];
      trusted-public-keys = [
        "starrfox.cachix.org-1:f72kZolyxFrJtrWoLRj12WdEx4xISSOybSlQ21HuhWY="
        "nixtop:rKqWcytequgtEKVF2QGMEWDJSe3JA0RjwunI/WkkTfY="
      ];
    };
  };
}
