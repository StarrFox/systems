{config, ...}: {
  age.secrets.harmonia_signing_key = {
    file = ../../../secrets/harmonia_signing_key.age;
    mode = "400";
    owner = "harmonia";
  };

  services.harmonia = {
    enable = true;
    signKeyPath = config.age.secrets.harmonia_signing_key.path;
  };

  networking.firewall.allowedTCPPorts = [5000];
}
