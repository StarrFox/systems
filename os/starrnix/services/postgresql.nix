{...}: {
  services.postgresql = {
    enable = true;
    ensureDatabases = [
      "discord_chan"
      "smitestat"
    ];
    ensureUsers = [
      {
        name = "starr";
        ensurePermissions = {
          "DATABASE discord_chan" = "ALL PRIVILEGES";
          "DATABASE smitestat" = "ALL PRIVILEGES";
        };
      }
    ];
  };
}
