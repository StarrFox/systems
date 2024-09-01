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
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "ehci_pci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" "rtsx_usb_sdmmc"];
      kernelModules = [];
    };
    kernelModules = ["kvm-amd"];
    supportedFilesystems = ["ntfs"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/8BF5-DD74";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-uuid/f43fb9a4-7712-40dc-b799-8eeaf2f2c40f";
      fsType = "ext4";
    };
    "/big" = {
      device = "/dev/disk/by-uuid/426AFB966AFB8547";
      fsType = "ntfs";
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/4b0061d6-2f50-465e-b8b5-3b873fe6655d";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
