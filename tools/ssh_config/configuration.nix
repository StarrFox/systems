{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = ["https://starrfox.cachix.org"];
    trusted-public-keys = ["starrfox.cachix.org-1:f72kZolyxFrJtrWoLRj12WdEx4xISSOybSlQ21HuhWY="];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
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

  # uncomment for gui
  # services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # sound.enable = true;
  # hardware.pulseaudio.enable = false;
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  # };

  users.users.starr = {
    isNormalUser = true;
    description = "starr";
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCViqZxkOWaP9R0DgLLbgarWKnN1SjkQcboqK6fqnBNeSDl9dcKvmqi6nBSSHCGOkKPdlzZtN17CmRzbMFqU4honvEjA5LmeC1q8bS11xz2DDcjR94xX31DSr933aO/T8GJVO0t04j7kJrpEuK+LyeQuPDgAJKbge6x+s7aXp/nuHbmfPTogUpMKJdDiM7SWfhgIAQkCWqo7kcc3xgN7JDWjW418wNjmJdnR9PlPCCJ3ec+xSEuph3cS+N6/IaTTMxSk/PotrIWaGYbMg0XOji/xFn/OzNTME4Bm8+AvN9iywyIZdiNTd26JPMeemXoPIDb8W0pBjK32qHcRrgaVECzXeL4K0/7aOba4yb+m/jZPQwEbhUBgcXXG3mMQp7n376G4TfLT0mezHpUmEQzw+jTO6y4fuFQP2CBmFXE82vu5kD6pZmwoglNPVu+ADdQw3t47DYIkKLHsWTNNXcSMfWxpMalkVprS9mrotLk+fue2rgnBkc/zcIASSfrNSW5Z7M= starr@starrnix"
    ];
  };
  security.sudo.wheelNeedsPassword = false;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "starr";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    helix
    git
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "23.05";
}
