{ config, lib, modulesPath, ... }: {
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    "/" ={
      device = "/dev/disk/by-uuid/87d416e0-7907-4db7-a7e2-428053defaf5";
      fsType = "ext4";
    };

    "/boot" ={
      device = "/dev/disk/by-uuid/392A-C3FE";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    # todo: why is this ntfs
    "/big" = {
      device = "/dev/disk/by-uuid/426AFB966AFB8547";
      fsType = "ntfs";
    };
  };

  swapDevices =[
    { device = "/dev/disk/by-uuid/4883e788-39a6-418a-a59c-38388d310a3d"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}