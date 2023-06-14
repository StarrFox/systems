{config, ...}: {
  age.secrets.arcanumbot_token = {
    file = ../../../secrets/arcanumbot_token.age;
    mode = "400";
    owner = "arcanumbot";
  };

  services.arcanumbot = {
    enable = true;
    tokenFile = config.age.secrets.arcanumbot_token.path;
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [
      "arcanumbot"
    ];
    ensureUsers = [
      {
        name = "arcanumbot";
        ensurePermissions = {
          "DATABASE arcanumbot" = "ALL PRIVILEGES";
        };
      }
    ];
  };
}
