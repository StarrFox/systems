{config, ...}: {
  imports = [
    ./docker.nix
  ];

  age.secrets.cloudflared_token = {
    file = ../../../secrets/cloudflared_token.age;
    mode = "400";
    owner = "root";
  };

  virtualisation.oci-containers.containers.cloudflared = {
    image = "cloudflare/cloudflared:latest";
    autoStart = true;
    cmd = ["tunnel" "run"];
    environmentFiles = [config.age.secrets.cloudflared_token.path];
    user = "root:root";
  };
}
