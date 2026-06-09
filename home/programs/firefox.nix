{config, ...}: {
  programs.firefox = {
    enable = true;
    # TODO: remove on new install
    configPath = ".mozilla/firefox";
    profiles = {
      ${config.home.username} = {
        search = {
          default = "ddg";
          force = true;
        };
        settings = {
          "browser.toolbars.bookmarks.visibility" = "always";
        };
        userChrome = ''
          :root[titlepreface="no bar"] #navigator-toolbox {
            visibility: hidden;
            height: 0;
          }
        '';
      };
    };
  };
}
