{pkgs, lib, ...}: {
  # this is such a janky solution
  systemd.services.jellyseerr_split_tunnel = {
    description = "add jellyseerr to mullvad split tunnel";
    after = [ "jellyseerr.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${lib.getExe pkgs.fish} -c \"mullvad split-tunnel clear && systemctl show --property MainPID jellyseerr.service | awk -F \"=\" '{print $2}' | xargs mullvad split-tunnel add\"";
      Type = "oneshot";
      RemainAfterExit = true;
      User = "starr";
    };
  };
}