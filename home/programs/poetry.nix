{pkgs, ...}: {
  xdg.configFile."pypoetry/config.toml" = {
    enable = true;
    source = pkgs.writers.writeTOML "config.toml" {
      virtualenvs.in-project = true;
    };
  };
}