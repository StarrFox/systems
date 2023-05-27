{...}:
{
  services.postgresql = {
    enable = true;
    ensureDatabases = [
      "discord_chan"
    ];
    ensureUsers = [
      {
        name = "starr";
        ensurePermissions = {
          "DATABASE discord_chan" = "ALL PRIVILEGES";
        };
      }
    ];
  };
}