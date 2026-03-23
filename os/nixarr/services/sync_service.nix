{ pkgs, lib, ... }: {
  systemd.services.sync_service = {
    description = "Sync media";
    serviceConfig = {
      User = "starr";
      WorkingDirectory = "/home/starr";
      ExecStart = "${ lib.getExe pkgs.fish } -c 'just sync'";
    };
    wantedBy = [ "multi-user.target" ];
  };

  systemd.timers.sync_service_timer = {
    description = "Run sync service every hour";
    timerConfig = {
      OnBootSec = "10min";
      OnUnitActiveSec = "10min";
      Unit = "sync_service.service";
    };
    wantedBy = [ "timers.target" ];
  };
}
