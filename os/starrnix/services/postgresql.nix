_: {
  services.postgresql = {
    enable = true;
    ensureDatabases = [
      "smitestat"
      "arcanumbot"
      "discord_chan"
    ];
    ensureUsers = [
      {
        name = "starr";
        ensurePermissions = {
          "DATABASE smitestat" = "ALL PRIVILEGES";
          "DATABASE arcanumbot" = "ALL PRIVILEGES";
          "DATABASE discord_chan" = "ALL PRIVILEGES";
        };
      }
    ];
  };
}
