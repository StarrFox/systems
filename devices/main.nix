{
  config,
  lib,
  modulesPath,
  pkgs,
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
    # TODO: remove this line when it works
    # manually set 6.2 to try and fix bluetooth
    kernelPackages = pkgs.linuxPackages_latest;
  };

  #boot.loader.efi.efiSysMountPoint = "/boot/efi";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/b8bfd5d6-f08e-4321-b779-e18e287a8e0d";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/E3D2-CE34";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
    #"/big" = {
    #  device = "/dev/disk/by-label/big";
    #  fsType = "ext4";
    #};
    #"/big_fast" = {
    #  device = "/dev/disk/by-label/big_fast";
    #  fsType = "ext4";
    #};
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/bad4f116-113d-4ce1-9f52-1adf4051ecb2";
    }
  ];

  hardware = {
    graphics = {
      enable = true;
      # no idea what this does, but everyone else uses it
      enable32Bit = true;

      # something about nvdec whatever that is
      extraPackages = with pkgs; [nvidia-vaapi-driver];
    };

    # corsair mouse config
    #ckb-next.enable = true;

    nvidia = {
      open = true;
      # nvidia driver
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      # enables drm
      # NOTE: drm does not refer to the copyright type of drm
      # see: https://en.wikipedia.org/wiki/Direct_Rendering_Manager
      modesetting.enable = true;
    };
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  services.xserver.videoDrivers = ["nvidia"];

  nixpkgs.hostPlatform = "x86_64-linux";
}
