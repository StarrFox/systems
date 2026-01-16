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
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDKitn2TYaX+Szl9LpMm7Zyyj9388VP/jytDGe41d0MNPSiKEMtZpwyx2pqrtayMYI2vr92UpPUJ/l80X/37MNXdPqb4eyNbysJvDqPksCejUTMccLaVXMxKv/FlkTZye5C88YqO9MrEpYfK0qKoyPIIOnMTybFEneAO2WOSMSM/GaRzQtBnhE7Yqx4hqL/2zyiM2RPAIZGQxVAm5mJqtzlLUlBbYiuRPOxyH19M0LBsdx/3HShbaf4ZRHAMPtii07NKgnr/GDKAqcoDWwnN1bBosI89sVWRSnBXz3DEoG+2m+xtq/U+fUwjr29eGTA0v7wTuKRt3VoprRyT8reOAnkeNhd/UrtsZLJCSoW+PDsIdqofwUwo5zZavzeFtxXrHgFOcHFsjLbT69Sv5UPVb93IbKrcNQmmM2j7FjCytVgJ64SruzS+9B7FyaVDAo5R66e4HI1twC7YORhf8lZN2deWX74Ylwi9Eehswj4Gjrm7rrh3d3ZYdB+GrRDpKRwWjs= starr@nixmain"
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

  system.stateVersion = "25.11";
}
