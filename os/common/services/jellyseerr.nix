{inputs, pkgs, config, ...}: let
  nixpkgs-unstable = import inputs.nixpkgs-unstable {
    system = "${pkgs.system}";
    inherit (config.nixpkgs) config;
  };
in {
  # TODO: 23.11 reenable
  # services.jellyseerr = {
  #   enable = true;
  #   openFirewall = true;
  # };

  # nixos module didn't have a .package so had to do this for unstable
  systemd.services.jellyseerr = {
    description = "Jellyseerr, a requests manager for Jellyfin";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    environment.PORT = "5055";
    serviceConfig = {
      Type = "exec";
      StateDirectory = "jellyseerr";
      WorkingDirectory = "${nixpkgs-unstable.jellyseerr}/libexec/jellyseerr/deps/jellyseerr";
      DynamicUser = true;
      ExecStart = "${nixpkgs-unstable.jellyseerr}/bin/jellyseerr";
      BindPaths = [ "/var/lib/jellyseerr/:${nixpkgs-unstable.jellyseerr}/libexec/jellyseerr/deps/jellyseerr/config/" ];
      Restart = "on-failure";
      ProtectHome = true;
      ProtectSystem = "strict";
      PrivateTmp = true;
      PrivateDevices = true;
      ProtectHostname = true;
      ProtectClock = true;
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectKernelLogs = true;
      ProtectControlGroups = true;
      NoNewPrivileges = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      RemoveIPC = true;
      PrivateMounts = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 5055 ];
}