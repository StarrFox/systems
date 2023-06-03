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
}