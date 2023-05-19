# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, lib, config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "starrnix";
  # uncommit for wifi
  # networking.wireless.enable = true;

  networking.networkmanager.enable = true;
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
    layout = "us";
    xkbVariant = "";
  };

  services.xserver = {
    enable = true;
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
  ];

  users.users.starr = {
    isNormalUser = true;
    description = "starr";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    initialHashedPassword = "$y$j9T$FF0N8WmrfwlzpN924bHgF/$h6MQqAxuOLe1LiS.1GqOx104aUbwtyho9lnLocm4iq3";
  };

  services.getty.autologinUser = "starr";
  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      neovim
      python3
    ];
    variables = {
      EDITOR = "nvim";
    };
    sessionVariables = {
      FLAKE = "/home/starr/systems";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "22.11"; # Did you read the comment?
}

