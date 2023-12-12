{config, ...}: {
  programs.firefox = {
    enable = true;
    profiles = {
      ${config.home.username} = {
        search = {
          default = "DuckDuckGo";
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
