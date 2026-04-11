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
    supportedFilesystems = ["ntfs" "nfs"];
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = [];
    };
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
    "/big" = {
     device = "/dev/disk/by-label/big";
     fsType = "ext4";
    };
    "/big_fast" = {
     device = "/dev/disk/by-label/big_fast";
     fsType = "ext4";
    };
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

    # corsair mouse driver
    ckb-next = {
      enable = true;
      package = (pkgs.ckb-next.overrideAttrs (finalAttrs: prevAttrs: {
        cmakeFlags = ["-DUSE_DBUS_MENU=0"] ++ prevAttrs.cmakeFlags;
        # TODO: https://github.com/ckb-next/ckb-next/pull/1275
        src = pkgs.fetchFromGitHub {
          owner = "AlexLiniu";
          repo = "ckb-next";
          rev = "35899e731e0e61d6f08d27186632dbf6f0e06d9e";
          hash = "sha256-CtlBMHkRcfXX71a2lhyJJNrk7EO/5sG+BecWCARjW+Q=";
        };
      }));
    };

    nvidia = {
      open = false;
      # nvidia driver
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      # enables drm
      # NOTE: drm does not refer to the copyright type of drm
      # see: https://en.wikipedia.org/wiki/Direct_Rendering_Manager
      modesetting.enable = true;
    };
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  # ckb-next needs this to see usb devices
  environment.systemPackages = [pkgs.usbutils];

  services.xserver.videoDrivers = ["nvidia"];

  nixpkgs.hostPlatform = "x86_64-linux";
}
