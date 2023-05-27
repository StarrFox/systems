{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
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
          :root[titlepreface="no bar"] #navigator-toolbox-background {
            visibility: hidden;
            height: 0;
          }
        '';
      };
    };
  };
}
