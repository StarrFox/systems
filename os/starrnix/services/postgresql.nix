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
        # TODO: 23.11 ensureClauses (see options page)
        ensurePermissions = {
          "DATABASE smitestat" = "ALL PRIVILEGES";
          "DATABASE arcanumbot" = "ALL PRIVILEGES";
          "DATABASE discord_chan" = "ALL PRIVILEGES";
        };
      }
    ];
  };
}
