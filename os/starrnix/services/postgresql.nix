_: {
  services.postgresql = {
    enable = true;
    ensureDatabases = [
      "smitestat"
      "discord_chan"
    ];
    ensureUsers = [
      {
        name = "starr";
        ensurePermissions = {
          "DATABASE smitestat" = "ALL PRIVILEGES";
        };
      }
      {
        name = "discord_chan";
        ensurePermissions = {
          "DATABASE discord_chan" = "ALL PRIVILEGES";
        };
      }
    ];
  };
}
