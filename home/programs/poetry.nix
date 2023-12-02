{pkgs, ...}: {
  # TODO: 23.11 unstable no longer needed
  xdg.configFile."pypoetry/config.toml" = {
    enable = true;
    source = pkgs.writers.writeTOML "config.toml" {
      virtualenvs.in-project = true;
      virtualenvs.prefer-active-python = true;
    };
  };
}