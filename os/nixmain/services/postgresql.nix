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
        # NOTE: imparitive changes are preserved; i.e. changing this will not
        #  change an existing user
        ensureClauses.superuser = true;
      }
    ];
  };
}
