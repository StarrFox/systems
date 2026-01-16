# from: https://github.com/FreshlyBakedCake/Patisserie/blob/940505258279fe07f19b2a0de08a98b3dbd2ffe7/modules/nixos/cooling/OpenLinkHub/default.nix#L10
# waiting on https://github.com/NixOS/nixpkgs/pull/447973 to be merged

{pkgs, lib, ...}: let
  pkg = (pkgs.openlinkhub.overrideAttrs ({
      postPatch = ''
      substituteInPlace src/systeminfo/systeminfo.go \
        --replace-fail '"lspci"' '"${lib.getExe' pkgs.pciutils "lspci"}"'
    '';
  }));
in {
  users.users.openlinkhub = {
    isSystemUser = true;
    group = "openlinkhub";
  };
  users.groups.openlinkhub = { };

systemd.services.OpenLinkHub = let
      path = "/var/lib/OpenLinkHub";
    in {
      enable = true;
      description = "Open source interface for iCUE LINK System Hub, Corsair AIOs and Hubs";

      preStart = ''
        mkdir -p ${path}/database
        [ -f ${path}/database/rgb.json ] || cp ${pkg}/var/lib/OpenLinkHub/rgb.json ${path}/database/rgb.json
        mkdir -p ${path}/database/temperatures
        mkdir -p ${path}/database/profiles
        mkdir -p /run/udev/rules.d

        mkdir -p ${path}/database/keyboard
        cp -r -n ${pkg}/var/lib/OpenLinkHub/database/keyboard ${path}/database/keyboard

        #cp $#{cfg.config} $#{path}/config.json

        [ -L ${path}/static ] || ln -s ${pkg}/var/lib/OpenLinkHub/static ${path}/static
        [ -L ${path}/web ] || ln -s ${pkg}/var/lib/OpenLinkHub/web ${path}/web

        ${pkgs.usbutils}/bin/lsusb -d 1b1c: | while read -r line; do
        ids=$(echo "$line" | ${pkgs.gawk}/bin/awk '{print $6}')
        vendor_id=$(${pkgs.coreutils}/bin/echo "$ids" | ${pkgs.coreutils}/bin/cut -d':' -f1)
        device_id=$(${pkgs.coreutils}/bin/echo "$ids" | ${pkgs.coreutils}/bin/cut -d':' -f2)
        ${pkgs.coreutils}/bin/cat > /run/udev/rules.d/99-corsair-openlinkhub-"$device_id".rules <<- EOM
        KERNEL=="hidraw*", SUBSYSTEMS=="usb", ATTRS{idVendor}=="$vendor_id", ATTRS{idProduct}=="$device_id", MODE="0666"
        EOM
        done

        ${pkgs.coreutils}/bin/chmod -R 744 ${path}
        ${pkgs.coreutils}/bin/chown -R OpenLinkHub:OpenLinkHub ${path}

        ${pkgs.systemd}/bin/udevadm control --reload
        ${pkgs.systemd}/bin/udevadm trigger
      '';

      postStop = ''
        ${pkgs.coreutils}/bin/rm /var/lib/OpenLinkHub/web
        ${pkgs.coreutils}/bin/rm /var/lib/OpenLinkHub/static

        ${pkgs.coreutils}/bin/rm /run/udev/rules.d/99-corsair-openlinkhub-*.rules
        ${pkgs.systemd}/bin/udevadm control --reload
        ${pkgs.systemd}/bin/udevadm trigger
      '';

      path = [ pkgs.pciutils ];

      serviceConfig = {
        DynamicUser = true;
        ExecStart = "${pkg}/bin/OpenLinkHub";
        ExecReload = "${pkgs.coreutils}/bin/kill -s HUP \$MAINPID";
        RestartSec = 5;
        PermissionsStartOnly = true;
        StateDirectory = "OpenLinkHub";
        WorkingDirectory = "/var/lib/OpenLinkHub";
      };

      wantedBy = [ "multi-user.target" ];
    };

  environment.systemPackages = [ pkg ];

  services.udev.packages = [ pkg ];
}