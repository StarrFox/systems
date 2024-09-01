# TODO: make apps declaritive after I know which I want
{
  pkgs,
  config,
  ...
}: {
  age.secrets.nextcloud_pass = {
    file = ../../../secrets/nextcloud_pass.age;
    mode = "400";
    owner = "nextcloud";
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud29;
    inherit (config.networking) hostName;
    config = {
      adminuser = "starr";
      adminpassFile = config.age.secrets.nextcloud_pass.path;
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
