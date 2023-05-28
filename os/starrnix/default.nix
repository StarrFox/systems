{
  inputs,
  lib,
  config,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./services/mullvad.nix
    ./services/openssh.nix
    ./services/postgresql.nix
    ./services/ratbagd.nix
    ./services/syncthing.nix
    ./services/tailscale.nix
    ./services/xbanish.nix
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
    };
    # this makes nix * commands use the same nixpkgs versions as the system
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      trusted-users = ["@wheel"];
      trusted-substituters = [
        "https://hydra.nixos.org"
      ];
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        # TODO: change to true eventually
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot/efi";
      };
    };
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      kernelModules = [];
    };
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
    supportedFilesystems = ["ntfs"];
  };

  networking = {
    hostName = "starrnix";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    # wifi
    #wireless.enable = true;
  };

  time.timeZone = "Etc/UTC";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    videoDrivers = ["nvidia"];
    displayManager = {
      autoLogin = {
        enable = true;
        user = "starr";
      };
      sddm = {
        enable = true;
        autoNumlock = true;
      };
    };
    desktopManager.plasma5.enable = true;
  };

  hardware = {
    opengl.enable = true;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

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
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/050acb3c-9365-4f58-9af8-d53d59dd9c73";
    }
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # if Jack needed
    # jack.enable = true;
  };

  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    (nerdfonts.override {fonts = ["FiraCode"];})
    material-icons
  ];

  users.users.starr = {
    isNormalUser = true;
    description = "starr";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "audio"];
    shell = pkgs.fish;
    initialHashedPassword = "$y$j9T$FF0N8WmrfwlzpN924bHgF/$h6MQqAxuOLe1LiS.1GqOx104aUbwtyho9lnLocm4iq3";
  };

  programs.fish.enable = true;

  services.getty.autologinUser = "starr";

  environment = {
    systemPackages = with pkgs; [
      neovim
      git
    ];
    variables = {
      EDITOR = "nvim";
    };
    sessionVariables = {
      # TODO: find a better way to handle this
      FLAKE = "/home/starr/systems";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };

  security.sudo.wheelNeedsPassword = false;

  # TODO: how do I do this just for the starr user
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      libsForQt5.xdg-desktop-portal-kde
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "22.11";
}
