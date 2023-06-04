{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./services/mullvad.nix
    ./services/openssh.nix
    ./services/postgresql.nix
    ./services/ratbagd.nix
    ./services/syncthing.nix
    ./services/tailscale.nix
    ./services/xbanish.nix
    ./services/discord_chan.nix
    ../../devices/main.nix
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
      substituters = [
        "https://starrfox.cachix.org"
      ];
      trusted-public-keys = [
        "starrfox.cachix.org-1:f72kZolyxFrJtrWoLRj12WdEx4xISSOybSlQ21HuhWY="
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

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

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

  # ensures starr user's shell exists
  programs.fish.enable = true;

  services.getty.autologinUser = "starr";

  age.secrets.test = {
    file = ../../secrets/test.age;
    mode = "400";
    owner = "starr";
  };

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

  nixpkgs.config.allowUnfree = true;

  security.sudo.wheelNeedsPassword = false;

  # TODO: how do I do this just for the starr user
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.firejail.enable = true;

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

  system.stateVersion = "23.05";
}
