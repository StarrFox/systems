{config, ...}: {
  age.secrets.discord_chan_token = {
    file = ../../../secrets/discord_chan_token.age;
    mode = "400";
    owner = "discord_chan";
  };

  services.discord_chan = {
    enable = true;
    tokenFile = config.age.secrets.discord_chan_token.path;
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [
      "discord_chan"
    ];
    ensureUsers = [
      {
        name = "discord_chan";
        # TODO: 23.11 switch to ensureDBOwnership i.e. ensureDBOwnership = true;
        ensurePermissions = {
          "DATABASE discord_chan" = "ALL PRIVILEGES";
        };
      }
    ];
  };
}
