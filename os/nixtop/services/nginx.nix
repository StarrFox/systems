_: let
  email = "starrfox6312@gmail.com";
in {
  services.nginx = {
    enable = true;
    statusPage = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedTlsSettings = true;
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = email;
    certs = {
      "git.nixtop.attlocal.net".email = email;
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
