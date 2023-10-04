{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
    supportedFilesystems = ["ntfs"];
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = [];
    };
  };

  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/9f21177b-4aca-4fc6-9dcd-28517d9dbc96";
      fsType = "ext4";
    };
    "/boot/efi" = {
      device = "/dev/disk/by-uuid/6806-5F13";
      fsType = "vfat";
    };
    "/big" = {
      device = "/dev/disk/by-label/big-drive";
      fsType = "ext4";
    };
    "/little" = {
      device = "/dev/disk/by-label/little";
      fsType = "ext4";
    };
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/050acb3c-9365-4f58-9af8-d53d59dd9c73";
    }
  ];

  hardware = {
    opengl.enable = true;
    # nvidia driver
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  services.xserver.videoDrivers = ["nvidia"];
  nixpkgs.hostPlatform = "x86_64-linux";
}
