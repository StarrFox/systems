# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  nix = {
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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixtop";

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

  # nixtop is a laptop
  services.logind.lidSwitch = "ignore";

  programs.fish.enable = true;

  users.users.starr = {
    isNormalUser = true;
    description = "starr";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
    initialHashedPassword = "$y$j9T$FF0N8WmrfwlzpN924bHgF/$h6MQqAxuOLe1LiS.1GqOx104aUbwtyho9lnLocm4iq3";
  };

  services.getty.autologinUser = "starr";
  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      neovim
      git
    ];
    variables = {
      EDITOR = "nvim";
    };
    sessionVariables = {
      FLAKE = "/home/starr/systems";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  # security.acme = {
  #   acceptTerms = true;
  #   defaults = {
  #     email = "starrfox6312@gmail.com";
  #   };
  # };

  services = {
    jellyfin = {
      enable = true;
    };
    vaultwarden = {
      enable = true;
    };
    # nginx = {
    #   enable = true;
    #   virtualHosts."example.org" = {
    #     enableACME = true;
    #     forceSSL = true;
    #     listen = [
    #       {
    #         addr = "localhost";
    #         port = 9000;
    #         ssl = true;
    #       }
    #     ];
    #     locations."/" = {
    #       proxyPass = "http://localhost:8096";
    #     };
    #   };
    # };
  };

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
