_: {
  services.postgresql = {
    enable = true;
    ensureDatabases = [
      "smitestat"
    ];
    ensureUsers = [
      {
        name = "starr";
        ensurePermissions = {
          "DATABASE smitestat" = "ALL PRIVILEGES";
        };
      }
    ];
  };
}
