_: {
  services.nginx = {
    enable = true;
    statusPage = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
  };

  # security.acme = {
  #   acceptTerms = true;
  #   defaults.email = "starrfox6312@gmail.com";
  # };

  networking.firewall.allowedTCPPorts = [80 443];
}
