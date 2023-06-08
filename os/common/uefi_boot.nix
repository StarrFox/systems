_: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        # TODO: why was this added and why does it make the vm not work
        #efiSysMountPoint = "/boot/efi";
      };
    };
  };
}
